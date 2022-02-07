//
//  MainViewModel.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/2/22.
//

import Foundation
import Combine

extension BPMMainView {
    class ViewModel: ObservableObject {
        private let tapEngine = TapTempoEngine()
        private let haTimer = HighAccuracyTimer()
        private let audioEngine = AudioEngine()
        private let hapticEngine = HapticEngine()
        
        private var store: [AnyCancellable] = []
        
        @Published var tempo: String = "0"
        @Published var pendingTaps: String? = nil
        @Published var isPlaying: Bool = false
        
        @Published var playHaptic = false
        @Published var playAudio = false
        
        
        private lazy var bpmFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.alwaysShowsDecimalSeparator = false
            formatter.maximumFractionDigits = 1
            formatter.maximumIntegerDigits = 3
            formatter.numberStyle = .decimal
            
            return formatter
        }()
        
        private func formatBPM(value: Double) -> String {
            return bpmFormatter.string(from: NSNumber(value: value)) ?? "0"
        }
        
        private func subscribeToEngine() {
            tapEngine.$tempo
                .sink { value in
                    self.tempo = self.formatBPM(value: value)
                }
                .store(in: &store)
            
            tapEngine.$pendingTaps
                .sink { value in
                    if let value = value {
                        if value == 1 {
                            self.pendingTaps = "1 more tap"
                        } else {
                            self.pendingTaps = "\(value) more taps"
                        }
                    } else {
                        self.pendingTaps = nil
                    }
                }
                .store(in: &store)
        }
        
        private func subscribeToTimer() {
            haTimer.timerFired
                .sink { _ in
                    #warning("Create something flashing in the UI")
                    self.handleTimerFired()
                }
                .store(in: &store)
        }
        
        private func handleTimerFired() {
            if self.playAudio {
                self.audioEngine.play()
            }
            
            if self.playHaptic {
                self.hapticEngine.playHaptic()
            }
        }
        
        init() {
            subscribeToEngine()
            subscribeToTimer()
        }
        
        func tap() {
            // I think I need to either stop playback while there are pending taps or else update the timer each time there's a tap.
            // I'll see how I like it both ways, but right now there's a bug where the timer doesn't update if you tap while it's playing.
            tapEngine.tap()
        }
        
        func play() {
            guard tapEngine.tempo > 0 else { return }
            if !haTimer.started {
                haTimer.start(repeatDelay: 60.0 / tapEngine.tempo)
                isPlaying = true
            }
        }
        
        func stop() {
            if haTimer.started {
                haTimer.stop()
                isPlaying = false
            }
        }
    }
}
