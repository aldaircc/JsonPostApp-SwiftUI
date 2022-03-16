//
//  PostView.swift
//  JsonPostApp
//
//  Created by Aldair Cosetito Coral on 14/03/22.
//

import SwiftUI

struct PostView: View {
    // MARK: - Variables
    private var postVM = PostViewModel()
    @State var postsData:[PostModel] = []
    
    @State private var tabSelected:Int = 1
    
    @ViewBuilder
    func generateText(text:String) -> some View {
        Text(text)
            .foregroundColor(.red)
    }
    
    init() {
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $tabSelected) {
                    Text("All").tag(1)
                    Text("Favorites").tag(2)
                }
                .foregroundColor(.red)
                .pickerStyle(.segmented)
                .padding()
                
                List(postsData, id: \.id) { post in
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.blue)
                        Text(post.title)
                    }
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("Delete All")                    .frame(maxWidth: .infinity)
                }
                .background(.red)
                .foregroundColor(.white)
                .buttonStyle(.bordered)
                .controlSize(.large)
                .padding(.bottom, 1)
                
            }
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Refresh data")
                    }) {
                        Image(systemName: "arrow.clockwise")
//                            .tint(.white)
                    }
                }
            })
            .navigationBarHidden(false)
            .ignoresSafeArea(edges: .top)
        }
        .onAppear {
            self.postsData = self.postVM.getPost() ?? []
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
