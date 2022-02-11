//
//  InfoNavView.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/11/22.
//

import SwiftUI

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
