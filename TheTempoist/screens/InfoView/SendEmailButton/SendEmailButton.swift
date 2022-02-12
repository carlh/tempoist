//
//  SendEmailButton.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/12/22.
//

import SwiftUI
import MessageUI

struct SendEmailButton: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = SendEmailButtonViewModel()
    
    var body: some View {
        Button {
            vm.sendEmail()
        } label: {
            Text("Send email")
        }
        .buttonStyle(.bordered)
        .sheet(isPresented: $vm.showMailComposeView) {} content: {
            MFMailComposeView()
        }
    }
}

struct SendEmailButton_Previews: PreviewProvider {
    static var previews: some View {
        SendEmailButton()
    }
}
