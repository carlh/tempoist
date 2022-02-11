//
//  InfoNavView.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/11/22.
//

import SwiftUI

struct InfoNavView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Background()
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 32) {
                    NavigationLink {
                        Text("Details")
                    } label: {
                        HStack {
                            Text("About me")
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.light)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding()
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

struct InfoNavView_Previews: PreviewProvider {
    static var previews: some View {
        InfoNavView()
            .preferredColorScheme(.dark)
        InfoNavView()
    }
}
