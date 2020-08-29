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
    @State var currentFrameIndex = 0
    //var frames:[Image]

    var body: some View {

        VStack{

            ScrollView (.horizontal, showsIndicators: false) {
                 HStack {
                    ForEach( getFrames() , id: \.self ){ frame in
                        frame.image
                     }
                 }
            }.frame(height: 100)


        }
    }

    func getArray()-> [Int]{
        var arr:[Int] = [Int]()
        for i in 0...100{
            arr.append(i)
        }
        return arr
    }

    func getFrames()-> [Frame]{
        var frames:[Frame] = [Frame]()

        for i in 0...101{
            let frame = Frame(index: i, imageName: ("i\(i)"), seconds: 0.0)
            frames.append(frame)
        }
        return frames
    }

}

struct FramePicker_Previews: PreviewProvider {
    static var previews: some View {
        FramePicker()
    }
}
