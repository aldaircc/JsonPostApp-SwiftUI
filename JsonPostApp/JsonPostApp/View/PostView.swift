//
//  PostView.swift
//  JsonPostApp
//
//  Created by Aldair Cosetito Coral on 14/03/22.
//

import SwiftUI

struct PostView: View {
    @State var posts:[String] = ["1", "2", "3", "4", "5"]
    var body: some View {
        VStack {
            Spacer()
            
            List(posts, id: \.self) { x in
                Text("\(x)")
            }
            
            Button(action: {}) {
                Text("Delete All")                    .frame(maxWidth: .infinity)
            }
            .background(.red)
            .foregroundColor(.white)
            .buttonStyle(.bordered)
            .controlSize(.large)
            .padding(.bottom, 1)

        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
