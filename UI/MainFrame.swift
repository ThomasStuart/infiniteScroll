//
//  MainFrame.swift
//  infiniteScroll
//
//  Created by Thomas James Stuart on 8/28/20.
//  Copyright © 2020 Thomas James Stuart. All rights reserved.
//

import SwiftUI

struct MainFrame: View {
    var imageName:String
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width:300, height:300)
    }
}

struct MainFrame_Previews: PreviewProvider {
    static var previews: some View {
        MainFrame(imageName: "golfSwingTop")
    }
}
