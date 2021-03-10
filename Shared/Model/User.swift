//
//  User.swift
//  Splotch (iOS)
//
//  Created by Cameron Braverman on 1/7/21.
//

import Foundation

class User: ObservableObject {
    @Published var username: String?
    @Published var accessToken: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImNvbXBhbnkiOiJoZXkifQ.ynhNcK684ZsuCKUKaVErb990PZoG92iFDrflWtQ1rIU"
    @Published var refreshToken: String?
    
    func login(username: String, password: String) {
        print("Logged in")
    }
    
    static let shared = User()
    
//    init(username: String, accessToken: String, refreshToken: String) {
//        self.username = username
//        self.accessToken = accessToken
//        self.refreshToken = refreshToken
//    }
}
