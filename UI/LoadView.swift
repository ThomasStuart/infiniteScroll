//
//  LoadView.swift
//  infiniteScroll
//
//  Created by Thomas James Stuart on 8/31/20.
//  Copyright © 2020 Thomas James Stuart. All rights reserved.
//

import SwiftUI

struct LoadView: View {
    @State var doneConverting:Bool = false


    var body: some View {
        VStack{
            Text("\( String( self.doneConverting) )" )

        }
        .onAppear{
            FramePickerGenerator(
                videoURLString: "https://swing-videos.s3.us-east-2.amazonaws.com/TipsVideos2/HipRotation%40Backswing_Good.mp4",
                bind: self.$doneConverting)
        }
    }


}

struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadView()
    }
}
