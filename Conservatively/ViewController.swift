//
//  ViewController.swift
//  Conservatively
//
//  Created by Daniel Too on 18/08/14.
//  Copyright (c) 2014 Daniel Too. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    @IBOutlet weak var leftEye: UIImageView!
    @IBOutlet weak var rightEye: UIImageView!
    @IBOutlet weak var mouth: UIImageView!
    @IBOutlet weak var mouthConstraint: NSLayoutConstraint!
    @IBOutlet weak var tapButton: UIButton!
    
    var isMouthOpen = false
    
    var speaker = AVSpeechSynthesizer()
    var audioEngine = AVAudioEngine()
    var audioPlayer = AVAudioPlayerNode()
    var audioDelay = AVAudioUnitDelay()
    
    
    
    @IBAction func buttonTapped(sender: AnyObject) {
        println("tap")
        
        isMouthOpen = !isMouthOpen
        var amount = 0.0
        if (isMouthOpen) {
            amount = 1.0
        }
        openMouth(amount)
        
        
        // testing the speaking
        
        let speechUtterance = AVSpeechUtterance(string:"sue sue sue")
        speechUtterance.pitchMultiplier = 0.5

        speechUtterance.voice = AVSpeechSynthesisVoice(language:"en-AU")
        speaker.speakUtterance(speechUtterance)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        speaker.delegate = self
        
        // avaudioengine
        var audioInput  = audioEngine.inputNode
        var audioOutput = audioEngine.outputNode
        var format = audioInput.inputFormatForBus(0)
        
        audioEngine.attachNode(audioDelay)
        
        audioDelay.delayTime = 1.5
        audioDelay.feedback  = 40
        audioDelay.lowPassCutoff = 10000
        
        audioEngine.connect(audioInput, to: audioDelay, format: format)
        audioEngine.connect(audioDelay, to: audioOutput, format: format)
        
        var error:NSError?
        
        audioEngine.startAndReturnError(&error)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // animations
    
    let maxiumumMouthOffset = 30.0
    let mouthClosedY = 121.0
    
    func openMouth(openness : Double){
        
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            
            self.mouthConstraint.constant = CGFloat(self.mouthClosedY + openness * self.maxiumumMouthOffset)
            self.view.layoutIfNeeded()
            
        })
        
        
    }
    
    //text to speech
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didStartSpeechUtterance utterance: AVSpeechUtterance!) {
        
        openMouth(1.0);
        
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didFinishSpeechUtterance utterance: AVSpeechUtterance!) {
        
        openMouth(0.0);
    
        
    }

    
}

