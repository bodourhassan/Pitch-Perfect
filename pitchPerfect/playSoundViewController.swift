//
//  playSoundViewController.swift
//  pitchPerfect
//
//  Created by Ahmed Mokhtar on 1/4/20.
//  Copyright © 2020 bodour. All rights reserved.
//

import UIKit
import AVFoundation
class playSoundViewController: UIViewController {
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoPitchButton: UIButton!
    @IBOutlet weak var reverbPitchButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    
    var recordAudioUrl : URL!
    var audioFile : AVAudioFile!
    var audioEngine : AVAudioEngine!
    var audioPlayerNode : AVAudioPlayerNode!
    var stopTimer : Timer!
    
    enum buttonType : Int {case slow = 0 , fast , highPitch , lowPitch , echo , reverb}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(buttonType (rawValue: sender.tag)!)
        {
            case .slow :
                playSound(rate: 0.5)
            case .fast :
                playSound(rate: 1.5)
            case .highPitch :
                playSound(pitch : 1000)
            case .lowPitch:
                playSound(pitch : -1000)
            case .echo :
                playSound(echo : true)
            case .reverb :
                playSound(reverb : true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
         stopAudio()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
