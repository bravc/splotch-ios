//
//  SplotchApp.swift
//  Shared
//
//  Created by Cameron Braverman on 1/7/21.
//

import SwiftUI

@main
struct SplotchApp: App {
    @StateObject var user = User.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(user)
        }
    }
}
