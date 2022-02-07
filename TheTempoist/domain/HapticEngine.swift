//
//  HapticEngine.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/7/22.
//

import Foundation
import SwiftUI

class HapticEngine {
    func playHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
