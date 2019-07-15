//
//  CameraVC.swift
//  vlidea
//
//  Created by Fauzi Rizal on 09/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit


class CameraVC: UIViewController, AVCaptureFileOutputRecordingDelegate {
    
    
    // outlets
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var judulLabel: UILabel!
    @IBOutlet weak var onePhraseLabel: UILabel!
    @IBOutlet weak var collabWithLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var uniqueLabel: UILabel!
    @IBOutlet weak var boomingLabel: UILabel!
    
    // saved text from brainstorm vc
    var judul = ""
    var onePhrase = ""
    var collabWith = ""
    var settings = ""
    var unique = ""
    var booming = ""
    var savedVideoURL = ""
    
    
    
    // variables for camera
    let captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice?
    var videoFileOutput:AVCaptureMovieFileOutput?
    var cameraPreviewLayer:AVCaptureVideoPreviewLayer?
    
    var isRecording = false
    var toggleCameraGestureRecognizer = UISwipeGestureRecognizer()
    
    var zoomInGestureRecognizer = UISwipeGestureRecognizer()
    var zoomOutGestureRecognizer = UISwipeGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
        
        
        toggleCameraGestureRecognizer.direction = .up
        toggleCameraGestureRecognizer.addTarget(self, action: #selector(self.switchCamera))
        cameraView.addGestureRecognizer(toggleCameraGestureRecognizer)
        
        // Zoom In recognizer
        zoomInGestureRecognizer.direction = .right
        zoomInGestureRecognizer.addTarget(self, action: #selector(zoomIn))
        cameraView.addGestureRecognizer(zoomInGestureRecognizer)
        
        // Zoom Out recognizer
        zoomOutGestureRecognizer.direction = .left
        zoomOutGestureRecognizer.addTarget(self, action: #selector(zoomOut))
        cameraView.addGestureRecognizer(zoomOutGestureRecognizer)
        
        
        // outlets
        judulLabel.text = judul
        onePhraseLabel.text = onePhrase
        collabWithLabel.text = collabWith
        settingsLabel.text = settings
        uniqueLabel.text = unique
        boomingLabel.text = booming
    
    }
    
    
    // MARK: - Camera settings
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.high
    }
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        currentDevice = frontCamera
        
    }
    
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice!)
            captureSession.addInput(captureDeviceInput)
            videoFileOutput = AVCaptureMovieFileOutput()
            captureSession.addOutput(videoFileOutput!)
        } catch {
            print(error)
        }
    }
    
    func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.cameraView.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    func startRunningCaptureSession() {
        captureSession.startRunning()
    }
    
    
    // MARK: - Action methods
    
    @IBAction func capture(sender: UIButton) {
//        let oneMinuteTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: <#T##Selector#>, userInfo: nil, repeats: false)
        if !isRecording {
            isRecording = true
            
            let oneMinuteTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(doneTakingVideo), userInfo: nil, repeats: false)
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: { () -> Void in
                self.recordButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }, completion: {(done) in
                oneMinuteTimer.fire()
            })
            
            let outputPath = NSTemporaryDirectory() + "output\(judulLabel.text)\(onePhraseLabel.text).mov"
            let outputFileURL = URL(fileURLWithPath: outputPath)
            videoFileOutput?.startRecording(to: outputFileURL, recordingDelegate: self)
            
            
        } else {
            isRecording = false
            
            UIView.animate(withDuration: 0.5, delay: 1.0, options: [], animations: { () -> Void in
                self.recordButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
            recordButton.layer.removeAllAnimations()
            videoFileOutput?.stopRecording()
        }
    }
    
    // function to stop recording
    @objc func doneTakingVideo() {
        recordButton.layer.removeAllAnimations()
        videoFileOutput?.stopRecording()
    }
    
    
    // MARK: - AVCaptureFileOutputRecordingDelegate methods
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if error != nil {
            print(error)
            return
        }
        
//        let out = outputFileURL.dataRepresentation
//        let player = AVPlayer(url: outputFileURL)
//        let controller = AVPlayerViewController()
//        controller.player = player
//        present(controller, animated: true, completion: nil)
        
        savedVideoURL = "\(outputFileURL)"
        performSegue(withIdentifier: "videoFinishedSegue", sender: outputFileURL)
    }
    
    
    
    @objc func switchCamera() {
        captureSession.beginConfiguration()
        
        // Change the device based on the current camera
        let newDevice = (currentDevice?.position == AVCaptureDevice.Position.back) ? frontCamera : backCamera
        
        // Remove all inputs from the session
        for input in captureSession.inputs {
            captureSession.removeInput(input as! AVCaptureDeviceInput)
        }
        
        // Change to the new input
        let cameraInput:AVCaptureDeviceInput
        do {
            cameraInput = try AVCaptureDeviceInput(device: newDevice!)
        } catch {
            print(error)
            return
        }
        
        if captureSession.canAddInput(cameraInput) {
            captureSession.addInput(cameraInput)
        }
        
        currentDevice = newDevice
        captureSession.commitConfiguration()
    }
    
    @objc func zoomIn() {
        if let zoomFactor = currentDevice?.videoZoomFactor {
            if zoomFactor < 5.0 {
                let newZoomFactor = min(zoomFactor + 1.0, 5.0)
                do {
                    try currentDevice?.lockForConfiguration()
                    currentDevice?.ramp(toVideoZoomFactor: newZoomFactor, withRate: 1.0)
                    currentDevice?.unlockForConfiguration()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    @objc func zoomOut() {
        if let zoomFactor = currentDevice?.videoZoomFactor {
            if zoomFactor > 1.0 {
                let newZoomFactor = max(zoomFactor - 1.0, 1.0)
                do {
                    try currentDevice?.lockForConfiguration()
                    currentDevice?.ramp(toVideoZoomFactor: newZoomFactor, withRate: 1.0)
                    currentDevice?.unlockForConfiguration()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    // recording method
    func recordingMethod() {
        
    }
    
    
    // MARK: - Navigations
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        let rootVC = IdekuCVC()
        let navRootVC = UINavigationController(rootViewController: rootVC)
        UIApplication.shared.keyWindow?.rootViewController = navRootVC
//        self.navigationController?.popToViewController(rootVC, animated: true)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "videoFinishedSegue" {
            let goToFinishedTakingVideo = segue.destination as! FinishedTakingVideoVC
            goToFinishedTakingVideo.judul = judul
            goToFinishedTakingVideo.onePhrase = onePhrase
            goToFinishedTakingVideo.collabWith = collabWith
            goToFinishedTakingVideo.settings = settings
            goToFinishedTakingVideo.unique = unique
            goToFinishedTakingVideo.booming = booming
            goToFinishedTakingVideo.savedVideoURL = savedVideoURL
        }
    }
    
}
