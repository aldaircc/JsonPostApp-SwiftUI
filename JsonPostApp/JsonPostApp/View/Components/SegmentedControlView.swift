//
//  SegmentedControlView.swift
//  JsonPostApp
//
//  Created by Aldair Cosetito Coral on 15/03/22.
//

import SwiftUI

struct SegmentedControlView: View {
    // MARK: - Variables
    @State private var tabSelected:Int = 1
    @State private var currentPosition:CGFloat = 0
    
    init() {
    }
    
    var body: some View {
        VStack {
            Picker("", selection: $tabSelected) {
                Text("One").tag(1)
                Text("Two").tag(2)
                Text("Three").tag(3)
            }
            .pickerStyle(.segmented)
            .background(.green)
            .cornerRadius(8)
            .padding()
            
            GeometryReader { proxy in
                ZStack(alignment: .center) {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .size(width: proxy.size.width, height: 30)
                        .foregroundColor(Color.gray)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .size(width: proxy.size.width/4, height: 30)
                        .offset(x: currentPosition,
                                y: 0)
                        .animation(.easeOut, value: currentPosition)
                    
                    HStack(alignment: .center, spacing: proxy.size.width/4 - 60) {
                        
                        Button(action: {
                            self.currentPosition =  (proxy.size.width/4) * 0
                        }) {
                            Text("Option 1")
                        }
                        
                        Button(action: {
                            self.currentPosition = (proxy.size.width/4) * 1
                        }) {
                            Text("Option 2")
                        }
                        
                        Button(action: {
                            self.currentPosition = (proxy.size.width/4) * 2
                        }) {
                            Text("Option 3")
                        }
                        
                        Button(action: {
                            self.currentPosition = (proxy.size.width/4) * 3
                        }) {
                            Text("Option 4")
                        }
                    }
                    .padding([.top], 4)
                }
                .frame(width: .infinity, height: 20)
            }
            
        }
    }
}

struct SegmentedControlView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControlView()
    }
}
