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
                
                HStack {
                    playbackButton()
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
        .background(vm.isPlaying ? .red : .green)
        .foregroundStyle(.regularMaterial)
        .clipShape(Circle())
        .buttonStyle(.bordered)
        
    }
}

struct BPMMainView_Previews: PreviewProvider {
    static var previews: some View {
        BPMMainView()
            .preferredColorScheme(.dark)
        BPMMainView()
    }
}
