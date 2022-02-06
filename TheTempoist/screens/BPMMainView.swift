//
//  BPMMainView.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/2/22.
//

import SwiftUI

struct BPMMainView: View {
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        ZStack {
            Background()
            VStack(spacing: 64) {
                BPMDisplay(tempo: vm.tempo)
                    .offset(y: -150)
                
                TapButton(label: vm.pendingTaps ?? "Tap") {
                    vm.tap()
                }
            }
            .padding()
            
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct BPMMainView_Previews: PreviewProvider {
    static var previews: some View {
        BPMMainView()
            .preferredColorScheme(.dark)
        BPMMainView()
    }
}
