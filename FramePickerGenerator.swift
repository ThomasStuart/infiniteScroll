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
    @Binding var status: Bool
    @Binding var images:[Image]
    @Binding var framesComplete: Int
    @Binding var totalFrames:Int
    @Binding var progressValue:Float
    let generator: AVAssetImageGenerator
    let asset:AVURLAsset
    let framesPerSecond: Int32 = 30
    var times          = [NSValue]()
    var thumbnails     = [Thumbnail]()
    var thumbnailCache = NSCache<NSString, UIImage>()

    init(videoURLString: String, bind: Binding<Bool>, im: Binding<[Image]>, complete: Binding<Int>,total: Binding<Int>, progress: Binding<Float> ){
        print("I am created")
        let videoURL = URL(string: videoURLString) ?? URL(string: "")  //TODO:: MAKE A DEFUALT
        self.asset = AVURLAsset(url: videoURL!)
        self.generator = AVAssetImageGenerator(asset: asset)
        self.generator.appliesPreferredTrackTransform = true
        self.generator.requestedTimeToleranceBefore = CMTime(seconds: 0.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.generator.requestedTimeToleranceAfter = CMTime(seconds: 0.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self._status = bind
        self._images = im
        self._framesComplete = complete
        self._totalFrames    = total
        self._progressValue  = progress
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
            self.totalFrames = totalFrames
            print("TotalFrames: \(self.totalFrames)")
            self.populateThumbnails(totalFrames: totalFrames)
        }
        operationQueue.waitUntilAllOperationsAreFinished()
    }


    func populateThumbnails(totalFrames:Int )  {
         var times          = [NSValue]()
         var imgs           = [Image]()
         for i in 0..<2{
             imgs.append(Image("black-square"))
         }
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
                    let resized = img.resizeImage(newWidth: 255, newHeight: 424)
                    let thumbnail = Thumbnail(isSelected: false, associatedTime: requestedTime)
                    // set for UIImage resize
                    imgs.append( Image(uiImage: resized) )
                    self.framesComplete += 1
                    self.calculateProgress()
                    if requestedTime.value == totalFrames - 1 {
                        DispatchQueue.main.async {
                              print("Done")
                              print("total frames", totalFrames)
                             for i in 0..<5{
                                 imgs.append(Image("black-square"))
                             }
                              self.images = imgs
                              self.status = true
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


    func calculateProgress(){
        self.progressValue = Float(self.framesComplete) / Float(self.totalFrames)
    }

}
