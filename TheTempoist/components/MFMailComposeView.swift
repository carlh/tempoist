//
//  MFMailComposeView.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/12/22.
//

import SwiftUI
import MessageUI

struct MFMailComposeView: View, UIViewControllerRepresentable {
    let recipientEmail = "support@carlhinkle.com"
    let subject = "Tempoist Feedback"
    let body = "I have feedback or a support request."
    var mail: MFMailComposeViewController
    
    init() {
        mail = MFMailComposeViewController()
    }
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        mail.setToRecipients([recipientEmail])
        mail.setSubject(subject)
        mail.setMessageBody(body, isHTML: true)
        return mail
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        // NOP
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(mail: mail)
    }
    
    typealias UIViewControllerType = MFMailComposeViewController
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var mail: MFMailComposeViewController!
        
        init(mail: MFMailComposeViewController) {
            self.mail = mail
            super.init()
            self.mail.mailComposeDelegate = self
        }
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true) {}
        }
    }
}

struct MFMailComposeView_Previews: PreviewProvider {
    static var previews: some View {
        MFMailComposeView()
    }
}
