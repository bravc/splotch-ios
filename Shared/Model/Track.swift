//
//  Track.swift
//  Splotch (iOS)
//
//  Created by Cameron Braverman on 1/7/21.
//

import Foundation

struct TrackResponse: Decodable {
    var items: [Track]
}

struct Album: Codable {
    var name: String
    var images: [ImageJson]
}

struct ImageJson: Codable {
    var url: String
}

struct Artist: Codable {
    var name: String
}

class Track: ObservableObject, Decodable {
    @Published var name: String
    @Published var artists: [Artist]
    @Published var album: Album
    
    enum CodingKeys: CodingKey {
        case name, artists, album
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        artists = try container.decode([Artist].self, forKey: .artists)
        album = try container.decode(Album.self, forKey: .album)
    }
}
