//
//  BPMDisplay.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/6/22.
//

import SwiftUI

struct BPMDisplay: View {
    var tempo: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(tempo)
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.heavy)
            Text("BPM")
                .font(.system(.subheadline, design: .rounded))
                .fontWeight(.ultraLight)
        }
        .frame(width: 200, height: 200)
        .background(.ultraThinMaterial)
        .clipShape(Circle())
        .shadow(radius: 20)
    }
}

struct BPMDisplay_Previews: PreviewProvider {
    static var previews: some View {
        BPMDisplay(tempo: "120")
    }
}
