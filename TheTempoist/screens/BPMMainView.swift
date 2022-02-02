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
        VStack {
            Text("\(vm.tempo) bpm")
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
        }
    }
}

struct BPMMainView_Previews: PreviewProvider {
    static var previews: some View {
        BPMMainView()
    }
}
