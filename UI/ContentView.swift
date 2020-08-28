//
//  ContentView.swift
//  infiniteScroll
//
//  Created by Thomas James Stuart on 8/27/20.
//  Copyright © 2020 Thomas James Stuart. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: FramePicker() ) { Text("click to go to Frame Picker")}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
