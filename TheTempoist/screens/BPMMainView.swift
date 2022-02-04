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
                VStack(spacing: 8) {
                    Text("\(vm.tempo)")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.heavy)
                    Text("BPM")
                        .font(.system(.subheadline, design: .rounded))
                        .fontWeight(.ultraLight)
                }
                .frame(width: 200, height: 200)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .offset(y: -150)
                .shadow(radius: 20)
                
                Button {
                    vm.tap()
                } label: {
                    Text(vm.pendingTaps ?? "Tap")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.light)
                        .frame(width: 200, height: 55)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
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
