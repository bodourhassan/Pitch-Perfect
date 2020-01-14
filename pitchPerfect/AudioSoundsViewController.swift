//
//  AudioSoundsViewController.swift
//  pitchPerfect
//
//  Created by Ahmed Mokhtar on 12/22/19.
//  Copyright © 2019 bodour. All rights reserved.
//

import UIKit
import AVFoundation
class AudioSoundsViewController: UIViewController , AVAudioRecorderDelegate {

    @IBOutlet weak var RecordLabel: UILabel!
    @IBOutlet weak var RecordButton: UIButton!
    @IBOutlet weak var StropRecordButton: UIButton!
    
    var audioRecorder : AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StropRecordButton.isEnabled = false
        
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: start Record Audio Function
    
    @IBAction func RecordAudio(_ sender: Any) {
        configureUI(true)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    // MARK: Stop Record Function
    
    @IBAction func StopRecord(_ sender: Any) {
         configureUI(false)
        audioRecorder.stop()
        let audioSsssion = AVAudioSession.sharedInstance()
        try! audioSsssion.setActive(false)
    }
    // MARK: Configur UI
    func configureUI (_ recorderState :Bool)
    {
      if recorderState
      {
        RecordLabel.text = "Recording in progress"
        RecordButton.isEnabled = false
        StropRecordButton.isEnabled = true
      }
      else
      {
        RecordLabel.text = "Tap to record"
        RecordButton.isEnabled = true
        StropRecordButton.isEnabled = false
        
      }
    }
    // MARK: Audio Recorder Delegete
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
        performSegue(withIdentifier: "stopSegue", sender: audioRecorder.url)
        }
        else
        {
            print("the file not saved succefuly")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "stopSegue"
       {
         let playSoundVC = segue.destination as! playSoundViewController
         let recordAudioUrl = sender as! URL
         playSoundVC.recordAudioUrl = recordAudioUrl
        
        }
    }
}

