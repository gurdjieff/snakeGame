//
//  MusicManager.swift
//  Snake
//
//  Created by daiyuzhang on 03/02/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

import UIKit
import AVFoundation

var musicInstance:MusicManager!
class MusicManager: NSObject {
    
    class func shareMusicManager() ->MusicManager! {
        if (musicInstance == nil) {
            musicInstance = MusicManager()
            musicInstance.getPlayer()
        }
        return musicInstance;
    }
    
    var bgcAudio:AVAudioPlayer? = nil
    var biteAudio:AVAudioPlayer? = nil
    var successAudio:AVAudioPlayer? = nil
    var faileAudio:AVAudioPlayer? = nil

    
    func loadSound(filename:NSString) -> AVAudioPlayer {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: "mp3")
        var error:NSError? = nil
        let player = AVAudioPlayer(contentsOfURL: url, error: &error)
        player.prepareToPlay()
        return player
    }
    
    func getPlayer() {
        self.bgcAudio = loadSound("bgc")
        self.bgcAudio?.numberOfLoops = -1
        self.biteAudio = loadSound("bite1")
        self.successAudio = loadSound("up")
        self.faileAudio = loadSound("snda")
    }
}
