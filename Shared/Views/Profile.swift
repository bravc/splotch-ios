//
//  Profile.swift
//  Splotch (iOS)
//
//  Created by Cameron Braverman on 1/7/21.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var user: User
    @State var username: String = ""
    @State var password: String = ""
    
    
    var body: some View {
        VStack {
            VStack {
                Text("Last refreshed: ")
                Text("Current access token: \(User.shared.accessToken)")
            }
            TextField("Username", text: $username)
                .padding()
                .border(Color.black)
                .cornerRadius(3.0)
            TextField("Password", text: $password)
                .padding()
                .border(Color.black)
                .cornerRadius(3.0)
            HStack {
                Button("Login") {
                    user.login(username: username, password: password)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(Color.white)
                .border(Color.black)
                .cornerRadius(3)

            }
        }.padding()
            
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile().environmentObject(User())
    }
}
