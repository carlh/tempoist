//
//  TapButton.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/6/22.
//

import SwiftUI

struct TapButton: View {
    var label: String
    var onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            Text(label)
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.light)
                .frame(width: 200, height: 55)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .accessibilityLabel("Tap to set tempo.")
    }
}

struct TapButton_Previews: PreviewProvider {
    static var previews: some View {
        TapButton(label: "Tap") { }
    }
}
