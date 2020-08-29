//
//  FrameView.swift
//  infiniteScroll
//
//  Created by Thomas James Stuart on 8/28/20.
//  Copyright © 2020 Thomas James Stuart. All rights reserved.
//

import SwiftUI
import CoreMedia


struct Frame: Identifiable, Hashable{
    var id = UUID()
    var index: Int
    var imageName:String
    var seconds: Double
    var isSelected: Bool = false

    var image:some View{
        SmallFrameView(imageName:imageName)
    }

}


struct SmallFrameView: View {
    @State var isSelected = false
    var imageName:String

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width:64,height:64)
    }
}

struct SmallFrameView_Previews: PreviewProvider {
    static var previews: some View {
        SmallFrameView(imageName: "golfSwingTop")
//        SmallFrame(imageName: "golfSwingTop", associatedTime: CMTime(seconds: 0.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC)))
    }
}
