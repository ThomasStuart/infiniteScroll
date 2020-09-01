//
//  FramePicker.swift
//  infiniteScroll
//
//  Created by Thomas James Stuart on 8/28/20.
//  Copyright © 2020 Thomas James Stuart. All rights reserved.
//

import SwiftUI
import CoreMedia


struct FramePicker: View {
    @State var posX: CGFloat = 0
    @State var index:Int     = 0
    var Images: [Image]

    var body: some View {

        GeometryReader { geo in
            VStack {
                Text("X distance scrolled: \(self.posX * -1)")
                self.Images[self.index].resizable().frame(width: UIScreen.main.bounds.size.height/3, height: UIScreen.main.bounds.size.height/3 )
                Text("corresponding index: \(self.index) out of \(self.Images.count-1)")

                ScrollView(.horizontal, showsIndicators: true) {
                    VStack {
                        
                        GeometryReader { innerGeo -> Text in
                            self.posX = innerGeo.frame(in: .global).minX
                            self.index = self.getIndex(x: self.posX)
                            return Text("")
                        }.frame(height:1)

                        HStack(spacing: 0){
                            ForEach(0 ..< self.Images.count) {
                                SmallFrameView(currIndex: self.$index, id: $0, image: self.Images[$0] )
                            }
                        }//.padding(10)
                    }
                }
            }
        }
    }

    func getIndex(x:CGFloat ) -> Int {
        let frameSize    = 64
        let framePadding = 0
        let absX = x * -1.0
        let intX = Int(absX)
        return (intX / (frameSize + framePadding))
    }
    
}

struct FramePicker_Previews: PreviewProvider {
    static var previews: some View {
        FramePicker(Images: getImages())
    }
}
