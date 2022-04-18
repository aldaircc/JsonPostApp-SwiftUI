//
//  SegmentedControlView.swift
//  JsonPostApp
//
//  Created by Aldair Cosetito Coral on 15/03/22.
//

import SwiftUI

struct SegmentedItem: Identifiable {
    let id = UUID()
    let name: String
    let index: Int
}

struct SegmentedControlView: View {
    // MARK: - Variables
    @State private var tabSelected:Int = 1
    @State private var currentPosition:CGFloat = 0
    var options: [String]
    var items: [SegmentedItem] = []
    
    init(options: [String]) {
        self.options = options
        
        for option in options {
            self.items.append(SegmentedItem.init(name: option, index: self.items.count + 1))
        }
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
                VStack {
                    
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 5)
                            .size(width: proxy.size.width, height: 30)
                            .foregroundColor(Color.gray)
                        
                        RoundedRectangle(cornerRadius: 5)
                            .size(width: proxy.size.width/CGFloat(items.count), height: 30)
                            .offset(x: currentPosition,
                                    y: 0)
                            .animation(.easeOut, value: currentPosition)
                        
                        HStack(alignment: .center, spacing: proxy.size.width/CGFloat(items.count) - 60) {
                            
                            ForEach(items, id: \.id) { option in
                                
                                Button(action: {
//                                    self.currentPosition =  (proxy.size.width/CGFloat(option.index)) * 0
                                    
                                    self.currentPosition =  (proxy.size.width/CGFloat(items.count)) * CGFloat(option.index - 1)
                                }) {
                                    Text(option.name)
                                }
                            }
                            
                        }
                        .padding([.top], 4)
                        
                    }
                    .frame(width: .infinity, height: 20)
                    .padding(.bottom)
                    
                    
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
}

struct SegmentedControlView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControlView(options: ["All", "Favorites"])
    }
}
