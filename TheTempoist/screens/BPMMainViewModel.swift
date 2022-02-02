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
        private var store: [AnyCancellable] = []
        
        @Published var tempo: String = "0"
        @Published var pendingTaps: String? = nil
        
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
        
        init() {
            subscribeToEngine()
        }
        
        func tap() {
            tapEngine.tap()
        }
    }
}
