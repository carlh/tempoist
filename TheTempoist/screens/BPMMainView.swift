//
//  BPMMainView.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/2/22.
//

import SwiftUI

struct BPMMainView: View {
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        ZStack {
            Background()
            VStack(spacing: 64) {
                BPMDisplay(tempo: vm.tempo)
                
                beatDisplay()
                
                TapButton(label: vm.pendingTaps ?? "Tap") {
                    vm.tap()
                }
                .accessibilityLabel(vm.pendingTaps != nil ? "Keep tapping to set tempo." : "Tempo is \(vm.tempo). Tap to change.")
                
                playbackControls()
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
        
    }
    
    func beatDisplay() -> some View {
        HStack(alignment: .center, spacing: 30) {
            ForEach(0..<vm.beatsPerMeasure) { i in
                if !vm.isPlaying {
                    emptyBeat()
                } else if i <= vm.beatInMeasure {
                    filledBeat()
                } else {
                    emptyBeat()
                }
            }
        }
        
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
    }
    
    func filledBeat() -> some View {
        Color.green.opacity(0.6)
            .frame(height: 64)
            .mask(Circle())
            .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.green.opacity(0.8)))
    }
    
    func emptyBeat() -> some View {
        Color.green.opacity(0.5)
            .frame(height: 64)
            .mask(Circle().stroke(lineWidth: 2))
    }
    
    func playbackControls() -> some View {
        HStack(alignment: .center, spacing: 16) {
            audioControlButton()
            playbackButton()
            hapticControlButton()
        }
    }
    
    func playbackButton() -> some View {
        PlaybackButton(imageSystemName: vm.isPlaying ? "stop.fill" : "play.fill",
                       bgColor: vm.isPlaying ? .red : .green) {
            if vm.isPlaying {
                vm.stop()
            } else {
                vm.play()
            }
        }
                       .accessibilityLabel(vm.isPlaying ? "Stop clicks." : "Start clicks.")
    }
    
    func audioControlButton() -> some View {
        ControlButton(imageSystemName: vm.playAudio ? "speaker.fill" : "speaker.slash.fill") {
            vm.playAudio.toggle()
        }
        .accessibilityLabel(vm.playAudio ? "Mute clicks." : "Play clicks.")
    }
    
    func hapticControlButton() -> some View {
        ControlButton(imageSystemName: vm.playHaptic ? "bolt.fill" : "bolt.slash.fill") {
            vm.playHaptic.toggle()
        }
        .accessibilityLabel(vm.playHaptic ? "Don't vibrate on clicks." : "Vibrate on clicks.")
    }
}


struct BPMMainView_Previews: PreviewProvider {
    static var previews: some View {
        BPMMainView()
            .preferredColorScheme(.dark)
        BPMMainView()
    }
}
