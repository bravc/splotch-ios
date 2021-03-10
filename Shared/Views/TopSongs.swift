//
//  TopSongs.swift
//  Splotch (iOS)
//
//  Created by Cameron Braverman on 1/7/21.
//

import SwiftUI
import URLImage

class DataLayer: ObservableObject {
    @Published var tracks: [Track] = []
    @Published var loading = false
    
    init() {
        loading = true
        getTopTracks(timeRange: "short_term") { tracks in
            self.tracks = tracks
        }
        loading = false
    }
    
    func reload(timeRange: String) {
        loading = true
        getTopTracks(timeRange: timeRange) { tracks in
            self.tracks = tracks
        }
        loading = false
    }
}

struct TrackRow: View {
    @StateObject var track: Track
    
    var body: some View {
        HStack(spacing: 15) {
            URLImage(url: URL.init(string: track.album.images[0].url)!,
                 empty: {
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .redacted(reason: .placeholder)
                 },
                 inProgress: { _ in
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .redacted(reason: .placeholder)
                 },
                 failure: { error, retry in
                    VStack {
                        Text(error.localizedDescription)
                        Button("Retry", action: retry)
                    }
                 },
                 content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                 })
            VStack(alignment: .leading, spacing: 5) {
                Text(track.name)
                    .fontWeight(.bold)
                Text(track.artists[0].name)
                    .fontWeight(.light)
            }
        }.frame(height: 50)
    }
}

struct TopSongs: View {
    @State private var timeRange = "short_term"
    @ObservedObject var trackStore = DataLayer()
    @State private var sort: Int = 0
    @State private var popUpShown = true
    
    func changeNum() -> Void {
        print("Changed stuff")
    }
    
    var body: some View {
        VStack {
            Picker("Flavor", selection: $timeRange) {
                Text("Short").tag("short_term")
                Text("Medium").tag("medium_term")
                Text("Long").tag("long_term")
            }.onChange(of: timeRange, perform: { (value) in
                print(timeRange)
                trackStore.reload(timeRange: timeRange)
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding([.trailing, .leading])
            List {
                ForEach(trackStore.tracks, id: \.name) { track in
                    TrackRow(track: track)
                }.animation(.easeIn)
                .redacted(reason: trackStore.loading ? .placeholder : [])
            }.listStyle(PlainListStyle())
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Picker(selection: $sort, label: Text("Sorting options")) {
                        Text("15").tag(0)
                        Text("20").tag(1)
                        Text("50").tag(2)
                    }
                }
                label: {
                    Label("Sort", systemImage: "plus.circle")
                }.foregroundColor(.blue)
            }
        }
    }
    
}

struct TopSongs_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TopSongs()
                .navigationTitle(Text("Splotch"))
                .environmentObject(User())
        }
    }
}
