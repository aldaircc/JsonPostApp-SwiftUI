//
//  WebService.swift
//  JsonPostApp
//
//  Created by Aldair Cosetito Coral on 16/04/22.
//

import Foundation

struct CommonResponse: Codable {
    
    struct dResponse: Codable {
        enum CodingKeys: String, CodingKey {
            case termnConditionList = "TermConditionList"
        }
        
        var termnConditionList: [TermCondition]?
    }
    
    struct TermCondition: Codable {
        
        enum CodingKeys: String, CodingKey {
            case termId = "TermId"
            case termName = "TermName"
            case termDetail = "TermDetail"
            case requireSign = "RequireSign"
            case domainSignatureValidate = "DomainSignatureValidated"
        }
        
        let termId: String?
        let termName: String?
        let termDetail: String?
        let requireSign: String?
        let domainSignatureValidate: String?
    }
    
    var d: dResponse?
}

final class WebService {
    
    /*: Inicio Consumir servicio base64 */
    func consumeTermnsAndConditions() {
        //d {
            //TermConditionList: [
                //"TermId": "1826",
                //"TermName": "vinculacion_autogestiva_alta",
                //"RequireSign": "true",
                //"DomainSignatureValidated": "false"
            //]
        //}
        
        do {
            guard let url = Bundle.main.url(forResource: "get_tyc_response", withExtension: "json") else {
                return
            }
            
            if let data = try? Data(contentsOf: url) {
                let objectDecoded = try JSONDecoder().decode(CommonResponse.self, from: data)
                print(objectDecoded)
                
                if let base64 = objectDecoded.d?.termnConditionList?.first?.termDetail {
                    saveBase64StringToPDF(base64)
                }

            }
        } catch {
            print(error)
        }
    }
    
    func saveBase64StringToPDF(_ base64String: String) {

        guard
            var documentsURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last,
            let convertedData = Data(base64Encoded: base64String)
            else {
            //handle error when getting documents URL
            return
        }

        //name your file however you prefer
        documentsURL.appendPathComponent("yourFileName.pdf")

        do {
            try convertedData.write(to: documentsURL)
        } catch {
            //handle write error here
        }

        //if you want to get a quick output of where your
        //file was saved from the simulator on your machine
        //just print the documentsURL and go there in Finder
        print(documentsURL)
    }
    /*: Fin */
    
    func getPost(url: URL) async throws -> [PostModel] {
        let (data, _) = try await URLSession.shared.data(from: url)
        let posts = try? JSONDecoder().decode([PostModel].self, from: data)
        return posts ?? []
    }
    
    func getCommentsBy(postId: Int) async throws -> [CommentModel] {
        //https://jsonplaceholder.typicode.com/comments?postId=1
        var components = URLComponents(string: "https://jsonplaceholder.typicode.com/comments")
        components?.queryItems = [URLQueryItem.init(name: "postId", value: "\(postId)")]
        
        guard let url = components?.url else {
            throw NetworkError.badURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let comments = try? JSONDecoder().decode([CommentModel].self, from: data)
        
        return comments ?? []
    }
    
    func getCommentsByFromCallBack(postId: Int) async throws -> [CommentModel] {
        
        return try await withCheckedThrowingContinuation({ continuation in
            getCommentsBy(postId: postId) { response in
                switch response {
                case .success(let comments):
                    continuation.resume(returning: comments)
                    
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }
    
    private func getCommentsBy(postId: Int, completion: @escaping (Result<[CommentModel], Error>) -> Void ) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=\(postId)") else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil  else {
                completion(.failure(NetworkError.badURL))
                return
            }
            
            if let data = data {
                do {
                    let jsonDecoded = try JSONDecoder().decode([CommentModel].self, from: data)
                    completion(.success(jsonDecoded))
                } catch {
                    completion(.failure(NetworkError.errorConverting))
                }
            }
            
        }.resume()
    }
}
