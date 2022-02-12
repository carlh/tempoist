//
//  CHHapticEngine+Ext.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/12/22.
//

import Foundation
import CoreHaptics

extension CHHapticEngine {
    static func deviceSupportsHaptics() -> Bool {
        let hapticCapability = capabilitiesForHardware()
        return hapticCapability.supportsHaptics
    }
}
