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
                
                HStack(alignment: .center, spacing: 16) {
                    audioControlButton()
                    playbackButton()
                    hapticControlButton()
                }
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
        
    }
    
    func playbackButton() -> some View {
        Button {
            if vm.isPlaying {
                vm.stop()
            } else {
                vm.play()
            }
        } label: {
            Image(systemName: vm.isPlaying ? "stop.fill" : "play.fill")
                .font(.system(size: 44, weight: .regular, design: .rounded))
                .padding()
        }
        .frame(width: 95)
        .background(vm.isPlaying ? .red : .green)
        .foregroundStyle(.regularMaterial)
        .clipShape(Circle())
        .buttonStyle(.bordered)
        
    }
    
    func audioControlButton() -> some View {
        Button {
            vm.playAudio.toggle()
        } label: {
            Image(systemName: vm.playAudio ? "speaker.fill" : "speaker.slash.fill")
                .font(.system(size: 24, weight: .regular, design: .rounded))
                .padding()
        }
        .foregroundColor(Color(uiColor: .systemBackground))
        .background(Color.primary.opacity(0.3))
        .buttonStyle(.bordered)
        .clipShape(Circle())
    }
    
    func hapticControlButton() -> some View {
        Button {
            vm.playHaptic.toggle()
        } label: {
            Image(systemName: vm.playHaptic ? "bolt.fill" : "bolt.slash.fill")
                .font(.system(size: 24, weight: .regular, design: .rounded))
                .padding()
        }
        .foregroundColor(Color(uiColor: .systemBackground))
        .background(Color.primary.opacity(0.3))
        .buttonStyle(.bordered)
        .clipShape(Circle())
    }
}

struct BPMMainView_Previews: PreviewProvider {
    static var previews: some View {
        BPMMainView()
            .preferredColorScheme(.dark)
        BPMMainView()
    }
}
