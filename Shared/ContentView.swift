//
//  ContentView.swift
//  Shared
//
//  Created by Cameron Braverman on 1/7/21.
//

import SwiftUI

struct ContentView: View {
    struct PlaylistGenerator: View {
        var body: some View {
            Text("Generate Playlist")
        }
    }
    
    
    var body: some View {
            TabView {
                NavigationView {
                    TopSongs()
                        .navigationBarTitle(Text("Splotch"))
                }.tabItem {
                    Image(systemName: "list.dash")
                    Text("Top")
                }
                Profile()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
