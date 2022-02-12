//
//  ContactMeInfoView.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/11/22.
//

import SwiftUI

struct ContactMeInfoView: View {
    var body: some View {
        ZStack {
            Background()
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Get in touch")
                        .font(.system(.largeTitle, design: .rounded))
                    Text("I'd love to hear your comments and feedback. Please don't hesitate to reach out if you have any questions.  And, of course if you like Tempoist, please leave a review on the App Store.")
                    
                    HStack {
                        LeaveReviewButton()
                        SendEmailButton()
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("Contact me")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContactMeInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactMeInfoView()
        }
        .preferredColorScheme(.dark)
        
        NavigationView {
            ContactMeInfoView()
        }
    }
}
