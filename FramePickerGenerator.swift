//
//  FramePickerGenerator.swift
//  infiniteScroll
//
//  Created by Thomas James Stuart on 8/31/20.
//  Copyright © 2020 Thomas James Stuart. All rights reserved.
//

import Foundation
import CoreMedia
import AVFoundation
import SwiftUI
import CoreData

class FramePickerGenerator {
    var status:Binding<Bool>
    let generator: AVAssetImageGenerator
    let asset:AVURLAsset
    let framesPerSecond: Int32 = 30
    var times          = [NSValue]()
    var thumbnails     = [Thumbnail]()
    var thumbnailCache = NSCache<NSString, UIImage>()

    init(videoURLString: String, bind: Binding<Bool> ){
        print("I am created")
        let videoURL = URL(string: videoURLString) ?? URL(string: "")  //TODO:: MAKE A DEFUALT
        self.asset = AVURLAsset(url: videoURL!)
        self.generator = AVAssetImageGenerator(asset: asset)
        self.generator.appliesPreferredTrackTransform = true
        self.generator.requestedTimeToleranceBefore = CMTime(seconds: 0.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.generator.requestedTimeToleranceAfter = CMTime(seconds: 0.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.status = bind
        self.generateImagesfromVideo()

    }


    func generateImagesfromVideo() {
        print("generating images")
        let operationQueue = OperationQueue()
        operationQueue.addOperation {
            let assetTrack = self.asset.tracks(withMediaType: AVMediaType.video).first!
            let durationInSeconds: Float = Float(CMTimeGetSeconds(self.asset.duration))
            let framesPerSecond: Float = assetTrack.nominalFrameRate;
            let totalFrames = Int(durationInSeconds * framesPerSecond)
            self.populateThumbnails(totalFrames: totalFrames)
        }
        operationQueue.waitUntilAllOperationsAreFinished()
    }


    func populateThumbnails(totalFrames:Int )  {
        print("populating thumbnails")
        for second in 0..<totalFrames {
            times.append(CMTimeMake(value: Int64(second), timescale: 30) as NSValue)
        }

        // Generates the frames. Each frame processes an avg of 0.03 seconds currently. (33 frames per second)
        generator.generateCGImagesAsynchronously(forTimes: times) { (requestedTime, cgImage, actualImageTime, status, error) in
            switch status {
            case .succeeded: do {
                if let image = cgImage {
                    let img = UIImage(cgImage: image)
                    let resized = img.resizeImage(newWidth: 50, newHeight: 50)
                    let thumbnail = Thumbnail(isSelected: false, associatedTime: requestedTime)
                    self.thumbnails.append(thumbnail)
                    // set for UIImage resize
                    self.thumbnailCache.setObject(resized, forKey: requestedTime.seconds.description as NSString)

                    if requestedTime.value == totalFrames - 1 {
                        DispatchQueue.main.async {
                              print("Done")
                              print("total frames", totalFrames)
                              self.status = .constant(true)
    //                        self.thumbnailCollectionView.reloadData()
    //                        self.rotatingTipsLabel.isHidden = true
    //                        self.framePickerStackView.isHidden = false
    //                        self.selectFrameButton.isHidden = true
    //                        self.shouldAddAddressBlurView = true
    //                        self.blurScreen()
                        }
                    }
                } else {print("Failed to generate a valid image for time: \(String(describing: time))")}
                }
            case .failed: do {
                if let error = error {print("Failed to generate image with Error: \(error) for time: \(String(describing: time))")}
                else {print("Failed to generate image for time: \(String(describing: time))")}
                } case .cancelled: do { print("Image generation cancelled for time: \(String(describing: time))")}
            }
        }
    }


}
