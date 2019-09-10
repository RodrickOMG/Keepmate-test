//
//  WorkoutView.swift
//  Keepmate
//
//  Created by Rodrick Dai on 2019/8/7.
//  Copyright © 2019 Rodrick Dai. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Vision


class WorkoutViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var playFlag = 0
    let playerVC = AVPlayerViewController()
    
    var tag:String?
    
    let identifierLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = UIView(frame: view.bounds)
        view.backgroundColor = UIColor.white
        let screenFrame = UIScreen.main.bounds
        let screenWidth = screenFrame.size.width
        
        
        let back = UIButton(frame: CGRect(x: 10, y: 44, width: 20, height: 20))
        back.setBackgroundImage(UIImage(named: "arrow_back_left_navigation_previous_96px_1225467_easyicon.net"), for: UIControl.State())
        back.addTarget(self, action: #selector(backToLibrary), for: .touchUpInside)
        self.view.addSubview(back)
        
        //添加一个文本title
        let label = UILabel(frame: CGRect(x: 0, y: 44, width: 280, height: 30))
        label.text = tag
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.center = CGPoint(x: screenWidth/2, y: 56https://www.cnblogs.com/gejuncheng/p/8127446.html)
        self.view.addSubview(label)
    
        let mediaPath = Bundle.main.path(forResource: "Sunrise", ofType: "mp4")
        let mediaURL = URL(fileURLWithPath: mediaPath!)
        
        let avPlayer = AVPlayer(url:mediaURL as URL)
        
        playerVC.player = avPlayer
        playerVC.view.frame = CGRect(x: 20, y: 70, width: screenWidth - 40, height: 180)
        playerVC.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerVC.showsPlaybackControls = true

        self.present(playerVC, animated: true) {
            self.playerVC.player!.play()
        }
        
        self.view.addSubview(playerVC.view)
        
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = CGRect(x: 20, y: 270, width: screenWidth - 40, height: 400)
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        setupIdentifierConfidenceLabel()
        
        
//        let request = VNCoreMLRequest(model: <#T##VNCoreMLModel#>, completionHandler: <#T##VNRequestCompletionHandler?##VNRequestCompletionHandler?##(VNRequest, Error?) -> Void#>)
//        VNImageRequestHandler(cgImage: <#T##CGImage#>, options: [:]).perform(<#T##requests: [VNRequest]##[VNRequest]#>)
        
    }
    
    fileprivate func setupIdentifierConfidenceLabel() {
        view.addSubview(identifierLabel)
        identifierLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        identifierLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        identifierLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        identifierLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //        print("Camera was able to capture a frame:", Date())
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        // !!!Important
        // make sure to go download the models at https://developer.apple.com/machine-learning/ scroll to the bottom
        guard let model = try? VNCoreMLModel(for: SqueezeNet().model) else { return }
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
            
            //perhaps check the err
            
            //            print(finishedReq.results)
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            
            guard let firstObservation = results.first else { return }
            
            print(firstObservation.identifier, firstObservation.confidence)
            
            DispatchQueue.main.async {
                self.identifierLabel.text = "\(firstObservation.identifier) \(firstObservation.confidence * 100)"
            }
            
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    @objc func backToLibrary(btn:UIButton) {
        self.playerVC.player!.pause()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
