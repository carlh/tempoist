//
//  AboutMeInfoView.swift
//  TheTempoist
//
//  Created by Carl Hinkle on 2/11/22.
//

import SwiftUI

struct AboutMeInfoView: View {
    var body: some View {
        ZStack {
            Background()
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 24) {
                    Image("profileheadshot")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 256, height: 256)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                    
                    Text("Hi, I'm Carl")
                        .font(.system(.title, design: .rounded))
                    
                    Text("I'm an independent developer and a guitar player who needs better rhythm.")
                        .multilineTextAlignment(.center)
                        .font(.system(.headline, design: .rounded))
                    
                    Text("I built this app because I was looking for a fun project to learn more about SwiftUI, while also being useful.  Like a lot of guitar players, I've never been very good about practicing along with a metronome.  I know there are a bunch of really good metronome apps already on the app store (and I have more than one installed on my phone), but I'm hoping that since I actually built this one, maybe I'll actually use it 🤣.  I really hope that you find this simple metronome useful too, and I truly appreciate that you downloaded it.")
                        .font(.system(.body, design: .rounded))
                    
                    Text("For any developers out there, all of the code is available on my [GitHub](https://github.com/carlh/tempoist).  I'd be really happy if you report any bugs on the Issues page, and I'll do my best to fix them.  You're also welcome to make feature requests, but to be honest I'm not sure how many new features I'll be adding.  I guess we'll wait and see!" )
                        .multilineTextAlignment(.leading)
                        .font(.system(.body, design: .rounded))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
        }
        .navigationTitle("About me")
    }
}

struct AboutMeInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutMeInfoView()
                .preferredColorScheme(.dark)
        }
        NavigationView {
            AboutMeInfoView()
        }
    }
}
