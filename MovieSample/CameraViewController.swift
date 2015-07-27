//
//  CameraViewController.swift
//  MovieSample
//
//  Created by inkenkun on 2015/05/22.
//  Copyright (c) 2015年 inkenkun. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary
import GPUImage

class CameraViewController: UIViewController, AVCaptureFileOutputRecordingDelegate {

    var index = 2
    
    let captureSession = AVCaptureSession()
    let videoDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    let audioDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
    let fileOutput = AVCaptureMovieFileOutput()
    
    var startButton, stopButton : UIButton!
    var isRecording = false
    
    var videoCamera:GPUImageVideoCamera?
    var movieWriter:GPUImageMovieWriter?
    
    
    var movieFile : GPUImageMovieComposition?
    var filterView : GPUImageView?
    //var composition : AVMutableComposition
    //var transformVideoComposition : AVMutableVideoComposition
    var filter : GPUImagePolkaDotFilter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setMovie()
        
    }
    
    
    func setMovie(){
        
        
        let videoInput = AVCaptureDeviceInput.deviceInputWithDevice(self.videoDevice, error: nil) as! AVCaptureDeviceInput
        self.captureSession.addInput(videoInput)
        let audioInput = AVCaptureDeviceInput.deviceInputWithDevice(self.audioDevice, error: nil)  as! AVCaptureInput
        self.captureSession.addInput(audioInput);
        
        self.captureSession.addOutput(self.fileOutput)
        
        let videoLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(self.captureSession) as! AVCaptureVideoPreviewLayer
        videoLayer.frame = self.view.bounds
        videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer.addSublayer(videoLayer)

        
/*
        videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .Back)
        videoCamera!.outputImageOrientation = .Portrait;
        
        filter = GPUImagePolkaDotFilter()
        videoCamera?.addTarget(filter)
        filter?.addTarget(self.view as! GPUImageView)
        videoCamera?.startCameraCapture()
*/
        
        
        self.setupButton()
        self.captureSession.startRunning()
        
        
        
    }
    
    func setupButton(){
        self.startButton = UIButton(frame: CGRectMake(0,0,120,50))
        self.startButton.backgroundColor = UIColor.redColor();
        self.startButton.layer.masksToBounds = true
        self.startButton.setTitle("start", forState: .Normal)
        self.startButton.layer.cornerRadius = 20.0
        self.startButton.layer.position = CGPoint(x: self.view.bounds.width/2 - 70, y:self.view.bounds.height-50)
        self.startButton.addTarget(self, action: "onClickStartButton:", forControlEvents: .TouchUpInside)
        
        self.stopButton = UIButton(frame: CGRectMake(0,0,120,50))
        self.stopButton.backgroundColor = UIColor.grayColor();
        self.stopButton.layer.masksToBounds = true
        self.stopButton.setTitle("stop", forState: .Normal)
        self.stopButton.layer.cornerRadius = 20.0
        
        self.stopButton.layer.position = CGPoint(x: self.view.bounds.width/2 + 70, y:self.view.bounds.height-50)
        self.stopButton.addTarget(self, action: "onClickStopButton:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.startButton);
        self.view.addSubview(self.stopButton);
    }
    
    func onClickStartButton(sender: UIButton){
        if !self.isRecording {
            // start recording
            
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentsDirectory = paths[0] as! String
            let filePath : String? = "\(documentsDirectory)/temp.mp4"
            let fileURL : NSURL = NSURL(fileURLWithPath: filePath!)!
            fileOutput.startRecordingToOutputFileURL(fileURL, recordingDelegate: self)
            
/*
            let pathToMovie = NSHomeDirectory().stringByAppendingPathComponent("stream.mp4")
            unlink((pathToMovie as NSString).UTF8String)
            var movieURL = NSURL.fileURLWithPath(pathToMovie)
*/
            
            
            /*
            movieWriter = GPUImageMovieWriter(movieURL: fileURL, size: CGSizeMake(640, 480))
            movieWriter!.encodingLiveVideo = true
            
            filter = GPUImagePolkaDotFilter()
            videoCamera?.addTarget(filter)
            filter?.addTarget(movieWriter)
            videoCamera?.startCameraCapture()
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                self.movieWriter!.startRecording()
                self.videoCamera?.startCameraCapture()
            })
*/

            
            self.isRecording = true
            self.changeButtonColor(self.startButton, color: UIColor.grayColor())
            self.changeButtonColor(self.stopButton, color: UIColor.redColor())
        }
    }
    
    func onClickStopButton(sender: UIButton){
        if self.isRecording {
            fileOutput.stopRecording()
            
            //videoCamera?.stopCameraCapture()
            //self.movieWriter?.finishRecording()
            
            self.isRecording = false
            self.changeButtonColor(self.startButton, color: UIColor.redColor())
            self.changeButtonColor(self.stopButton, color: UIColor.grayColor())
        }
    }
    
    func changeButtonColor(target: UIButton, color: UIColor){
        target.backgroundColor = color
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAtURL fileURL: NSURL!, fromConnections connections: [AnyObject]!) {
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        let assetsLib = ALAssetsLibrary()
        assetsLib.writeVideoAtPathToSavedPhotosAlbum(outputFileURL, completionBlock: nil)
        
    }

}
