//
//  OtherAppsInfoView.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/11/22.
//

import SwiftUI

struct OtherAppsInfoView: View {
    var body: some View {
        ZStack {
            Background()
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 24) {
                    Text("Get Tuned")
                        .font(.system(.largeTitle, design: .rounded))
                    
                    Image("GetTuned")
                        .resizable()
                        .frame(width: 167, height: 167)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    
                    Text("A tuner with built in presets for all of your common guitar tunings. There's also a chromatic tuner so that it's easy to get your guitar, bass, banjo, or ukelele in perfect tune.  ")
                        .multilineTextAlignment(.leading)
                    
                    Button {
                        guard let getTunedUrl = URL(string: "https://apps.apple.com/app/id1440592987")
                        else { return }
                        Task {
                            await UIApplication.shared.open(getTunedUrl, options: [:])
                        }
                    } label: {
                        Text("Open in app store")
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
            }
        }
        .navigationTitle("My apps")
    }
}

struct OtherAppsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OtherAppsInfoView()
                .preferredColorScheme(.dark)
                .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}
