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
        }
    }
}

struct SegmentedControlView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControlView()
    }
}
