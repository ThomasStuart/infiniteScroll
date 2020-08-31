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


func getFrames()-> [Frame]{
    var frames:[Frame] = [Frame]()

    for i in 0...101{
        let frame = Frame(index: i, imageName: ("i\(i)"), seconds: 0.0)
        frames.append(frame)
    }
    return frames
}

struct Thumbnail {
    var isSelected: Bool
    var associatedTime: CMTime
}

//
//func createPreviewImageGenerator(asset: AVURLAsset) -> AVAssetImageGenerator {
//    let generator = AVAssetImageGenerator(asset: asset)
//    generator.appliesPreferredTrackTransform = true
//    generator.requestedTimeToleranceBefore = CMTime(seconds: 0.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
//    generator.requestedTimeToleranceAfter = CMTime(seconds: 0.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
//    return generator
//}
//
//func generateImagesfromVideo(videoURLString: String) {
//    let framesPerSecond: Int32 = 30
//    guard let videoURL = URL(string: videoURLString) else { return }
//    let asset = AVURLAsset(url: videoURL)
//    let generator = createPreviewImageGenerator(asset: asset)
//    let endTime = CMTime(seconds: asset.duration.seconds, preferredTimescale: framesPerSecond)
//
//    let operationQueue = OperationQueue()
//
//    operationQueue.addOperation {
//        let assetTrack = asset.tracks(withMediaType: AVMediaType.video).first!
//        let durationInSeconds: Float = Float(CMTimeGetSeconds(asset.duration))
//        let framesPerSecond: Float = assetTrack.nominalFrameRate;
//        let totalFrames = Int(durationInSeconds * framesPerSecond)
//        populateThumbnails(totalFrames: totalFrames)
//    }
//    operationQueue.waitUntilAllOperationsAreFinished()
//
//}
//
//
//// Populate Thumbnails
//func populateThumbnails(totalFrames:Int )  {
//    var generator: AVAssetImageGenerator!
//    var times          = [NSValue]()
//    var thumbnails     = [Thumbnail]()
//    let thumbnailCache = NSCache<NSString, UIImage>()
//
//    for second in 0..<totalFrames {
//        times.append(CMTimeMake(value: Int64(second), timescale: 30) as NSValue)
//    }
//
//    // Generates the frames. Each frame processes an avg of 0.03 seconds currently. (33 frames per second)
//    generator.generateCGImagesAsynchronously(forTimes: times) { (requestedTime, cgImage, actualImageTime, status, error) in
//        switch status {
//        case .succeeded: do {
//            if let image = cgImage {
//                let img = UIImage(cgImage: image)
//                let resized = img.resizeImage(newWidth: 50, newHeight: 50)
//                let thumbnail = Thumbnail(isSelected: false, associatedTime: requestedTime)
//                thumbnails.append(thumbnail)
//                // set for UIImage resize
//                thumbnailCache.setObject(resized, forKey: requestedTime.seconds.description as NSString)
//
//                if requestedTime.value == totalFrames - 1 {
//                    DispatchQueue.main.async {
//                          print("Done")
////                        self.thumbnailCollectionView.reloadData()
////                        self.rotatingTipsLabel.isHidden = true
////                        self.framePickerStackView.isHidden = false
////                        self.selectFrameButton.isHidden = true
////                        self.shouldAddAddressBlurView = true
////                        self.blurScreen()
//                    }
//                }
//            } else {print("Failed to generate a valid image for time: \(String(describing: time))")}
//            }
//        case .failed: do {
//            if let error = error {print("Failed to generate image with Error: \(error) for time: \(String(describing: time))")}
//            else {print("Failed to generate image for time: \(String(describing: time))")}
//            } case .cancelled: do { print("Image generation cancelled for time: \(String(describing: time))")}
//        }
//    }
//}



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
