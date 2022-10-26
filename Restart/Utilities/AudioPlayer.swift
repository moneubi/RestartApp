//
//  AudioPlayer.swift
//  Restart
//
//  Created by MBAYE Libasse on 26/10/2022.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String){
    
    if let path =  Bundle.main.path(forResource: sound, ofType: type){
        
        do{
            
            if #available(iOS 16.0, *) {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            } else {
                // Fallback on earlier versions
            }
            audioPlayer?.play()
        }catch{
            
            print("Could not playing...")
        }
    }
}
