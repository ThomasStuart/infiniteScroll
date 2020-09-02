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
    @State var posX: CGFloat    = 0
    @State var index:Int        = 0
    @State var tag: Int         = 0
    @State var done: Bool       = false
    @State var tagged: [Image]  = [Image]()
    var Images: [Image]

    var body: some View {

        VStack {
            Text("X distance scrolled: \(self.getAbs(x: self.posX))")
            self.Images[self.index].resizable().frame(width: UIScreen.main.bounds.size.height/3, height: UIScreen.main.bounds.size.height/3 )
            Text("corresponding index: \(self.index) out of \(self.Images.count-1)")

            TrackableScrollView(.horizontal, contentOffset: self.$posX, index: self.$index) {
                HStack(spacing: 10){
                    ForEach(0 ..< self.Images.count) {
                        SmallFrameView(currIndex: self.$index, id: $0, image: self.Images[$0] )
                    }
                }.padding(10)

            }.frame(height:100)

            Spacer().frame(height: 50)

            Button (action: {
                print("Button Clicked @ tag = \(self.tag)")
                self.tagged.append(self.Images[self.index]);
                if self.tag == 3 {
                    print("Entered If statement")
                    self.done = true
                }
                self.tag += 1;

            } ) {
                Text("Select Frame").foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue ).frame(width:255, height: 40))
            }

            Spacer().frame(height: 50)
            Text("tag: \(self.tag)")
            NavigationLink(destination: ViewSelectedFrames(Images: self.tagged), isActive: self.$done){ EmptyView() }
        }

    }

    func getAbs(x:CGFloat) -> CGFloat{
        return abs(x)
    }

}


struct FramePicker_Previews: PreviewProvider {
    static var previews: some View {
        FramePicker(Images: getImages())
    }
}
