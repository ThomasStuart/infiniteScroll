//
//  ViewSelectedFrames.swift
//  infiniteScroll
//
//  Created by Thomas James Stuart on 9/1/20.
//  Copyright © 2020 Thomas James Stuart. All rights reserved.
//

import SwiftUI

struct ViewSelectedFrames: View {
    var Images: [Image]

    var body: some View {
        VStack{
            HStack(spacing: 10){
                ForEach(0 ..< self.Images.count) {
                    self.Images[$0].resizable().frame(width: 100, height:100)
                }
            }.padding( 17)
        }
    }
}

struct ViewSelectedFrames_Previews: PreviewProvider {
    static var previews: some View {
        ViewSelectedFrames(Images: [Image("i2"), Image("i30"),Image("i50"),Image("i70")])
    }
}
