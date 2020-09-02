//
//  LoadView.swift
//  infiniteScroll
//
//  Created by Thomas James Stuart on 8/31/20.
//  Copyright © 2020 Thomas James Stuart. All rights reserved.
//

import SwiftUI
import CoreMedia
import AVFoundation
import CoreData

struct LoadView: View {
    @State var doneConverting:Bool  = false
    @State var images               = [Image]()
    @State var framesCompleted:Int  = 0
    @State var totalFrames:Int      = 0
    @State var progressValue:Float  = 0.0

    var body: some View {
        VStack{
            ProgressBar(value: $progressValue).frame(height: 20).padding()
            Text("Making frame \( String( self.framesCompleted) )  out of \(String(self.totalFrames + 7))" )
            if self.doneConverting{
                NavigationLink(destination: FramePicker(Images: images), isActive: $doneConverting){ EmptyView() }
            }
        }
        .onAppear{
            FramePickerGenerator(
                videoURLString: "https://swing-videos.s3.us-east-2.amazonaws.com/TipsVideos2/HipRotation%40Backswing_Good.mp4",
                bind: self.$doneConverting,
                im: self.$images,
                complete: self.$framesCompleted,
                total: self.$totalFrames,
                progress: self.$progressValue)
        }
    }

}

struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadView()
    }
}
