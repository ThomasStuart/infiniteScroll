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
        SmallFrame(imageName:imageName)
    }

    var time:CMTime{
        CMTime(seconds: seconds, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
    }
}


struct SmallFrame: View {
    var imageName:String
//    var associatedTime: CMTime
//    var isSelected: Bool = false

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width:50,height:50)
    }
}

//struct SmallFrame_Previews: PreviewProvider {
//    static var previews: some View {
//        SmallFrame(imageName: "golfSwingTop", associatedTime: CMTime(seconds: 0.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC)))
//    }
//}
