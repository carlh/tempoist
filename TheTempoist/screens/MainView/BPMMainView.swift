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
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 64) {
                BPMDisplay(tempo: vm.tempo)
                
                beatDisplay()
                
                tempoEntryRow()
                
                playbackControls()
            }
            .padding()
            
            
            HStack {
                Spacer()
                VStack {
                    Button {
                        vm.showInfoView = true
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.system(size: 28, weight: .regular, design: .rounded))
                    }
                    Spacer()
                }
            }
            .padding()
        }
        .sheet(isPresented: $vm.showInfoView, onDismiss: {
         
        }, content: {
            InfoNavView()
        })
        
        
    }
    
    func tempoEntryRow() -> some View {
        HStack {
            Button {
                vm.decrementTempo()
            } label: {
                Image(systemName: "minus")
                    .frame(width: 42, height: 42)
            }
            .buttonStyle(.bordered)
            .clipShape(Circle())
            .accessibilityLabel("Decrease tempo.")
            
            TapButton(label: vm.pendingTaps ?? "Tap") {
                vm.tap()
            }
            .accessibilityLabel(vm.pendingTaps != nil ? "Keep tapping to set tempo." : "Tempo is \(vm.tempo). Tap to change.")
            
            Button {
                vm.incrementTempo()
            } label: {
                Image(systemName: "plus")
                    .frame(width: 42, height: 42)
            }
            .buttonStyle(.bordered)
            .clipShape(Circle())
            .accessibilityLabel("Increase tempo.")
        }
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
            if vm.canPlayHaptics() {
                hapticControlButton()
            }
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
