//
//  TapTempoEngine.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/2/22.
//

import Foundation

fileprivate let windowSize = 3

class TapTempoEngine: ObservableObject {
    @Published var tempo: Double = 0.0
    @Published var pendingTaps: Int? = nil
    
    // Initialize a windowSize element array that will hold the last windowSize tap time differences
    private var tapSpacing: [Double] = []
    private var counter = 0
    private var lastTime = Date.now
    
    // There needs to be at least windowSize taps before we start updating, the counter should be reset after 2 seconds
    private var numTaps = 0
    private var tapTimer: Timer?
    
    init (initialTempo: Double = 0.0) {
        setupTempo(initialTempo)
    }
    
    func setTempo(_ tempo: Double) {
        setupTempo(tempo)
    }
    
    private func setupTempo(_ initialTempo: Double) {
        tempo = initialTempo
        
        // b/m * 1m/60s (Convert to beats per second)
        let ms = initialTempo * 1 / 60
        
        // Initialize the tapSpacing to the exact initial tempo
        tapSpacing = [Double](repeatElement(ms, count: windowSize))
    }
    
    private func setTimer() {
        tapTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { _ in
            self.numTaps = 0
        })
    }
    
    private func initialize() {
        tapSpacing = [Double](repeating: 0.0, count: windowSize)
        lastTime = Date.now
        numTaps = 1
        pendingTaps = windowSize - numTaps + 1
        setTimer()
    }
    
    private func computeTempo() {
        let sum = tapSpacing.reduce(0) { partialResult, next in
            partialResult + next
        }
        tempo = 60.0 / (sum / Double(windowSize))
        setTimer()
    }
    
    public func tap() {
        // Algorithm
        // 1. If this is the first tap, initialize the data and return
        // 2. Store the time difference between now and the previous tap
        // 3. Update the lastTime, counter, and numTaps
        // 4. If numTaps is less than or equal to the window size, update pending taps and return
        // 5. Otherwise, calculate the tempo
        
        // If first tap, clear tapSpacing, store Date.now in lastTime, don't insert, increment numTaps, start timer, return
        if numTaps == 0 {
            initialize()
            return
        }
        
        // Stop the timer
        tapTimer?.invalidate()
        
        let time = Date.now
        
        tapSpacing[counter] = lastTime.distance(to: time)
        lastTime = time
        numTaps += 1
        counter += 1
        counter %= windowSize
        
        if numTaps <= windowSize {
            // Don't start computing the average until the window is full
            // Update the pending taps status
            pendingTaps = windowSize - numTaps + 1
            return
        }
        
        pendingTaps = nil
        computeTempo()
    }
}
