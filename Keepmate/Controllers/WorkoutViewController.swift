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


class WorkoutViewController: UIViewController {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var playFlag = 0
    let playerVC = AVPlayerViewController()
    
    
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
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = CGRect(x: 20, y: 270, width: screenWidth - 40, height: 180)
    }
    
    @objc func backToLibrary(btn:UIButton) {
        self.playerVC.player!.pause()
        self.dismiss(animated: true, completion: nil)
    }
}
