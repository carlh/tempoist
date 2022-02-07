//
//  PlaybackButton.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/7/22.
//

import SwiftUI

struct PlaybackButton: View {
    let imageSystemName: String
    let bgColor: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: imageSystemName)
                .font(.system(size: 44, weight: .regular, design: .rounded))
                .padding()
        }
        .frame(width: 95)
        .background(bgColor)
        .foregroundStyle(.regularMaterial)
        .clipShape(Circle())
        .buttonStyle(.bordered)
    }
}

struct PlaybackButton_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackButton(imageSystemName: "play", bgColor: .green) {
            // NOP
        }
    }
}
