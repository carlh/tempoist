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
                Spacer()
                
                Text("\(vm.tempo) bpm")
                    .frame(width: 200, height: 200)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .offset(x: 0, y: -150)
                
                Button {
                    vm.tap()
                } label: {
                    if let pendingTaps = vm.pendingTaps {
                        Text(pendingTaps)
                    } else {
                        Text("Tap")
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            
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
