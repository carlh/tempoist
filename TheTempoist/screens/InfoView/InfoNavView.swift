//
//  InfoNavView.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/11/22.
//

import SwiftUI
import StoreKit

private struct InfoNavLink: View {
    var text: Text
    var body: some View {
        HStack {
            text
                .font(.system(.title2, design: .rounded))
                .fontWeight(.light)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding()
    }
}

struct InfoNavView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Background()
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        NavigationLink {
                            AboutMeInfoView()
                        } label: {
                            InfoNavLink(text: Text("About me"))
                        }
                        
                        NavigationLink {
                            OtherAppsInfoView()
                        } label: {
                            InfoNavLink(text: Text("Other apps"))
                        }
                        
                        NavigationLink {
                            ContactMeInfoView()
                        } label: {
                            InfoNavLink(text: Text("Contact me"))
                        }
                        
                        Text("If you find Tempoist useful, I'd really appreciate it if you would tap the button below and leave a review on the App Store.")
                            .font(.system(.subheadline, design: .rounded))
                        Button {
                            guard let writeReviewURL = URL(string: "https://apps.apple.com/app/id1609335829?action=write-review")
                            else { return }
                            Task {
                                await UIApplication.shared.open(writeReviewURL, options: [:])
                            }
                            
                        } label: {
                            Text("Leave review")
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding()
                    .navigationTitle("Info")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button {
                                dismiss()
                            } label: {
                                Text("Close")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct InfoNavView_Previews: PreviewProvider {
    static var previews: some View {
        InfoNavView()
            .preferredColorScheme(.dark)
        InfoNavView()
    }
}
