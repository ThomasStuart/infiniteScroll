//
//  TestNewScroll.swift
//  infiniteScroll
//
//  Created by Thomas James Stuart on 9/1/20.
//  Copyright © 2020 Thomas James Stuart. All rights reserved.
//

import SwiftUI

struct TestNewScroll: View {
    @State private var scrollViewContentOffset = CGFloat(0)
    var body: some View {

        VStack{
            Text("Content offset: \(Int(scrollViewContentOffset))")
            TrackableScrollView(.horizontal, contentOffset: $scrollViewContentOffset) {
                HStack{
                    ForEach(0..<101){ num in
                        Text(String(num))
                    }
                }
            }
        }
    }
}

struct TestNewScroll_Previews: PreviewProvider {
    static var previews: some View {
        TestNewScroll()
    }
}
