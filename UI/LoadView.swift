//
//  LoadView.swift
//  infiniteScroll
//
//  Created by Thomas James Stuart on 8/31/20.
//  Copyright © 2020 Thomas James Stuart. All rights reserved.
//

import SwiftUI
import CoreMedia
import AVFoundation
import CoreData

struct LoadView: View {
    @State var doneConverting:Bool = false
    @State var images = [Image]()
    let framesPerSecond: Int32 = 30


    var body: some View {
        VStack{
            Text("done making frames ? \( String( self.doneConverting) )" )
            if self.doneConverting{
                NavigationLink(destination: FramePicker(Images: images), isActive: $doneConverting){ EmptyView() }
            }
        }
        .onAppear{
            self.generateImagesfromVideo(videoURLString: "https://swing-videos.s3.us-east-2.amazonaws.com/TipsVideos2/HipRotation%40Backswing_Good.mp4")
        }
    }


    func generateImagesfromVideo(videoURLString: String) {
        print("I am created")
           let videoURL = URL(string: videoURLString) ?? URL(string: "")  //TODO:: MAKE A DEFUALT
           let asset = AVURLAsset(url: videoURL!)
           let generator = AVAssetImageGenerator(asset: asset)
           generator.appliesPreferredTrackTransform = true
           generator.requestedTimeToleranceBefore = CMTime(seconds: 0.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
           generator.requestedTimeToleranceAfter = CMTime(seconds: 0.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        print("generating images")
        let operationQueue = OperationQueue()
        operationQueue.addOperation {
            let assetTrack = asset.tracks(withMediaType: AVMediaType.video).first!
            let durationInSeconds: Float = Float(CMTimeGetSeconds(asset.duration))
            let framesPerSecond: Float = assetTrack.nominalFrameRate;
            let totalFrames = Int(durationInSeconds * framesPerSecond)
            self.populateThumbnails(totalFrames: totalFrames, generator: generator)
        }
        operationQueue.waitUntilAllOperationsAreFinished()
    }
    

    func populateThumbnails(totalFrames:Int, generator: AVAssetImageGenerator )  {
            var times          = [NSValue]()
            var imgs           = [Image]()

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
                       if requestedTime.value == totalFrames - 1 {
                           DispatchQueue.main.async {
                                 print("Done")
                                 print("total frames", totalFrames)
                                 self.images = imgs
                                 self.doneConverting = true
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

struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadView()
    }
}
