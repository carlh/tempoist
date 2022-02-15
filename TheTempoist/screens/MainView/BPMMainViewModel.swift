//
//  MainViewModel.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/2/22.
//

import Foundation
import Combine
import CoreHaptics

extension BPMMainView {
    class ViewModel: ObservableObject {
        private let tapEngine = TapTempoEngine()
        private let haTimer = HighAccuracyTimer()
        private let audioEngine = AudioEngine()
        private let hapticEngine = HapticEngine()
        
        let beatsPerMeasure = 4 // Maybe I'll make this configurable in a future update
        
        private var store: [AnyCancellable] = []
        
        @Published var tempo: String = "0"
        @Published var pendingTaps: String? = nil
        @Published var isPlaying: Bool = false
        @Published var beatInMeasure: Int = -1
        
        @Published var playHaptic = false {
            didSet {
                save(withTempo: tapEngine.tempo)
            }
        }
        @Published var playAudio = false {
            didSet {
                save(withTempo: tapEngine.tempo)
            }
        }
        
        @Published var showInfoView = false
        
        var canPlayHaptics = {
            return CHHapticEngine.deviceSupportsHaptics()
        }
        
        private var isInitialized = false
        
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
                    if self.isPlaying, value > 0 {
                        self.haTimer.updateTimer(repeatDelay: 60.0 / value)
                    }
                    self.save(withTempo: value)
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
                    self.handleTimerFired()
                }
                .store(in: &store)
        }
        
        private func handleTimerFired() {
            updateBeat()
            if self.playAudio {
                self.audioEngine.play()
            }
            
            if self.playHaptic {
                self.hapticEngine.playHaptic()
            }
        }
        
        private func updateBeat() {
            beatInMeasure = (beatInMeasure + 1) % beatsPerMeasure
        }
        
        private func load() {
            let defaults = UserDefaults.standard
            playAudio = defaults.bool(forKey: DefaultsKeys.soundEnabled)
            playHaptic = defaults.bool(forKey: DefaultsKeys.hapticEnabled)
            
            let storedTempo = defaults.double(forKey: DefaultsKeys.tempo)
            tapEngine.setTempo(storedTempo)
        }
        
        private func save(withTempo tempo: Double) {
            guard isInitialized else { return }
            let defaults = UserDefaults.standard
            defaults.set(playAudio, forKey: DefaultsKeys.soundEnabled)
            defaults.set(playHaptic, forKey: DefaultsKeys.hapticEnabled)
            defaults.set(tempo, forKey: DefaultsKeys.tempo)
        }
        
        init() {
            load()
            subscribeToEngine()
            subscribeToTimer()
            isInitialized = true
        }
        
        func tap() {
            tapEngine.tap()
        }
        
        func incrementTempo() {
            let tempo = floor(tapEngine.tempo)
            tapEngine.setTempo(Double(tempo + 1))
        }
        
        func decrementTempo() {
            let tempo = ceil(tapEngine.tempo)
            if tempo < 1 {
                return
            }
            tapEngine.setTempo(Double(tempo - 1))
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
            beatInMeasure = -1
        }
    }
}
