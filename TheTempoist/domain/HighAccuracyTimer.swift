//
//  HighAccuracyTimer.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/6/22.
//

import Foundation
import Combine

/// Because this app needs to play back music samples at a very precice interval, the standard Timer will not work.
/// I had a hard time finding a good example of how to build a precision timer without pulling in something like AudioKit (which I don't want to do for this app, but probably would for anything more complex).
/// This class is based on the small sample I found on SO https://stackoverflow.com/questions/43746336/high-precision-timer-in-swift
class HighAccuracyTimer: ObservableObject {
    private var timer: DispatchSourceTimer?
    
    @Published var started = false
    var timerFired = PassthroughSubject<Bool, Never>()
    
    var numberFormatter: NumberFormatter
    
    init() {
        numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 4
        numberFormatter.formatWidth = 5
    }
    
    func updateTimer(repeatDelay: TimeInterval) {
        stop()
        start(repeatDelay: repeatDelay)
    }
    
    func start(repeatDelay: TimeInterval) {
        let queue = DispatchQueue(label: "com.carlhinkle.thetempoist.timer", qos: .userInteractive)
        timer = DispatchSource.makeTimerSource(flags: .strict, queue: queue)
        timer?.schedule(deadline: .now(), repeating: repeatDelay, leeway: .nanoseconds(0))
        timer?.setEventHandler {
            // Is there a better way to send a one shot event?  Sending a Bool here is just a hack to send SOMETHING.
            self.timerFired.send(true)
        }
        timer?.resume()
        started = true
    }
    
    func stop() {
        timer?.cancel()
        started = false
    }
}

