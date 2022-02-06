//
//  AudioEngine.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/6/22.
//

import Foundation
import AVFoundation
import UIKit

class AudioEngine: ObservableObject {
    private var player: AVAudioPlayer? = nil
    
    init() {
        setupPlayer()
    }
    
    private func setupPlayer() {
        guard let bell50asset = NSDataAsset(name: "Bell50") else {
            fatalError("Could not load bell50")
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true, options: [.notifyOthersOnDeactivation])
            
            player = try AVAudioPlayer(data: bell50asset.data, fileTypeHint: "wav")
            player?.numberOfLoops = 0
            player?.prepareToPlay()
        } catch {
            print("Failed to load bell50: \(error.localizedDescription)")
        }
    }
    
    func play() {
        guard let player = player else {
            return
        }

        if player.isPlaying {
            player.stop()
            player.currentTime = 0
        }
        player.play()
    }
}
