//
//  SendEmailButtonViewModel.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/12/22.
//

import SwiftUI
import MessageUI


class SendEmailButtonViewModel: ObservableObject {
    @Published var showMailComposeView = false
    /**
     This function uses this answer https://stackoverflow.com/a/55765362/856786 to determine if the user has a non-default mail client available, and if so it uses that.
     */
    func sendEmail() {
        let recipientEmail = "support@carlhinkle.com"
        let subject = "Tempoist Feedback"
        let body = "I have feedback or a support request."
        
        if MFMailComposeViewController.canSendMail() {
            showMailComposeView = true
        } else if let emailUrl = createEmailUrl(to: recipientEmail, subject: subject, body: body) {
            UIApplication.shared.open(emailUrl, options: [:])
        }
    }
    
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        guard let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }
}
