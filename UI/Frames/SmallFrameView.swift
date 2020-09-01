//
//  FrameView.swift
//  infiniteScroll
//
//  Created by Thomas James Stuart on 8/28/20.
//  Copyright © 2020 Thomas James Stuart. All rights reserved.
//

import SwiftUI
import CoreMedia



struct SmallFrameView: View {
    @Binding var currIndex:Int
    @State var isSelected = false
    var id:Int
    var image:Image
    let imageSize:CGFloat = 64

    var body: some View {
        image
            .resizable()
            .frame(width:imageSize,height:imageSize)
            //.background( Rectangle().frame(width: imageSize+10, height: imageSize+10).foregroundColor( isSelected ? .red : .clear) )
            .background( Rectangle().frame(width: imageSize+10, height: imageSize+10).foregroundColor( currIndex == id ? .red : .clear) )
    }
}

struct SmallFrameView_Previews: PreviewProvider {
    static var previews: some View {
        SmallFrameView(currIndex: .constant(1) , id: 0 ,image: Image("i0") )
    }
}
