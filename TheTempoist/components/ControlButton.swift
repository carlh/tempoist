//
//  ControlButton.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/7/22.
//

import SwiftUI

struct ControlButton: View {
    var imageSystemName: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: imageSystemName)
                .font(.system(size: 24, weight: .regular, design: .rounded))
                .padding()
        }
        .foregroundColor(Color(uiColor: .systemBackground))
        .background(Color.primary.opacity(0.3))
        .buttonStyle(.bordered)
        .clipShape(Circle())
    }
}

struct ControlButton_Previews: PreviewProvider {
    static var previews: some View {
        ControlButton(imageSystemName: "bolt") {
            // NOP
        }
    }
}
