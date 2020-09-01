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
    @State var isSelected = false
    var image:Image
    let imageSize:CGFloat = 64

    var body: some View {
        image
            .resizable()
            .frame(width:imageSize,height:imageSize)
            .background( Rectangle().frame(width: imageSize+10, height: imageSize+10).foregroundColor( isSelected ? .red : .clear) )
    }
}

struct SmallFrameView_Previews: PreviewProvider {
    static var previews: some View {
        SmallFrameView(image: Image("i0") )
    }
}
