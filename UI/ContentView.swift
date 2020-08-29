//
//  ContentView.swift
//  infiniteScroll
//
//  Created by Thomas James Stuart on 8/27/20.
//  Copyright © 2020 Thomas James Stuart. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var posX: CGFloat = 0
    @State var index:Int = 0

    var body: some View {
        GeometryReader { geo in
            VStack {

                Text("\(self.posX * -1)")

                Image("i\(self.index)").resizable().aspectRatio(1, contentMode: .fit).frame(width: 255, height:424)

                Text("\(self.index)")

                ScrollView(.horizontal, showsIndicators: false) {
                    VStack {
                        GeometryReader { innerGeo -> Text in
                            self.posX = innerGeo.frame(in: .global).minX
                            self.index = self.getIndex(x: self.posX)
                            return Text("")
                        }.frame(height:1)

                        HStack(spacing: 10){
                            ForEach( getFrames() , id: \.self ){ frame in
                                frame.image
                            }
                        }.padding(10)
                    }
                }
            }
        }
    }

    func getIndex(x:CGFloat ) -> Int {
        let frameSize    = 64
        let framePadding = 10
        let absX = x * -1.0
        let intX = Int(absX)
        return (intX / (frameSize + framePadding))
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
