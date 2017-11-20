//
//  ViewController.swift
//  RecordExample
//
//  Created by August on 11/16/17.
//  Copyright © 2017 August. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController  , AVAudioRecorderDelegate , GStreamerBackendDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var play_button: UIButton!
    @IBOutlet weak var pause_button: UIButton!
    var gst_backend : GStreamerBackend!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        play_button.isEnabled = true;
        pause_button.isEnabled = true;
        
        gst_backend = GStreamerBackend(self)
           // GStreamerBackend((url: audioFilename, settings: settings)?

//  get the path of recording.m4a in the simulator
//        #if arch(i386) || arch(x86_64)
//            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as! NSString
//            NSLog("Document Path: %@", documentsPath)
//        #endif
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            recordButton.setTitle("Tap to Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            recordButton.setTitle("Tap to Re-record", for: .normal)
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
            // recording failed :(
        }
    }

    @IBAction func recordTapped(_ sender: UIButton) {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    @IBAction func play(_ sender: UIButton) {
        
        gst_backend.play()
    }
    
    @IBAction func pause(_ sender: UIButton) {
        
        gst_backend.pause()
    }
    
    /*
     * Methods from GstreamerBackendDelegate
     */
    func gstreamerSetUIMessage(_ message: String!) {
        DispatchQueue.main.async {
        }
    }
    
    func gstreamerInitialized()
    {
        print("Init Gtreamer")
        DispatchQueue.main.async {
            self.play_button.isEnabled = true;
            self.pause_button.isEnabled = true;
        }
        
    }
    
}

