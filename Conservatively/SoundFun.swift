//
//  SoundFun.swift
//  Conservatively
//
//  Created by Daniel Too on 19/08/14.
//  Copyright (c) 2014 Daniel Too. All rights reserved.
//

import AVFoundation
import CoreAudio

class SoundFun:NSObject, AVAudioRecorderDelegate {
    let recorder = AVAudioRecorder()
    var recordedTmpFile = "";
    
    func initAudioController () {
        let audioSession = AVAudioSession.sharedInstance()
        var error:NSError?
        
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error);
        
        
        
    }
    
}