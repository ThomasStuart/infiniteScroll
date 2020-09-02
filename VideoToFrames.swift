//
//  Video.swift
//  infiniteScroll
//
//  Created by Thomas James Stuart on 8/28/20.
//  Copyright © 2020 Thomas James Stuart. All rights reserved.
//

import Foundation
import CoreMedia
import AVFoundation
import SceneKit
import SwiftUI
import CoreData


func getImages()-> [Image]{
    var images:[Image] = [Image]()

    for i in 0..<2{
        images.append(Image("black-square"))
    }

    for i in 0...106{
        let image =  Image("i\(i)")
        images.append(image)
    }
    return images
}



struct Thumbnail {
    var isSelected: Bool
    var associatedTime: CMTime
}

extension UIImage {
    func resizeImage(newWidth: CGFloat, newHeight: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    func convertImageToBase64String() -> String {
        return self.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
}
