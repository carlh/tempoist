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
                    .offset(y: -100)
                
                TapButton(label: vm.pendingTaps ?? "Tap") {
                    vm.tap()
                }
                
                playbackControls()
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
        
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
    }
    
    func audioControlButton() -> some View {
        ControlButton(imageSystemName: vm.playAudio ? "speaker.fill" : "speaker.slash.fill") {
            vm.playAudio.toggle()
        }
    }
    
    func hapticControlButton() -> some View {
        ControlButton(imageSystemName: vm.playHaptic ? "bolt.fill" : "bolt.slash.fill") {
            vm.playHaptic.toggle()
        }
    }
}


struct BPMMainView_Previews: PreviewProvider {
    static var previews: some View {
        BPMMainView()
            .preferredColorScheme(.dark)
        BPMMainView()
    }
}
