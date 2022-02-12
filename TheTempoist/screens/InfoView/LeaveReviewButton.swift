//
//  LeaveReviewButton.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/12/22.
//

import SwiftUI

struct LeaveReviewButton: View {
    var body: some View {
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
}

struct LeaveReviewButton_Previews: PreviewProvider {
    static var previews: some View {
        LeaveReviewButton()
    }
}
