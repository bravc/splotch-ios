//
//  SplotchAPI.swift
//  Splotch (iOS)
//
//  Created by Cameron Braverman on 1/7/21.
//

import Foundation
import Alamofire

func genericGet<T: Decodable>(user: User, url: String, resource: T, success: @escaping (_ result: T) -> Void, error: @escaping (_ error: AFError) -> Void) {
    let headers: HTTPHeaders = [
        .authorization(bearerToken: user.accessToken),
        .accept("application/json")
    ]
    
    AF.request(url, headers: headers).validate().responseDecodable(of: T.self) { response in
        debugPrint("Response: \(response)")
        if let res = response.value {
            success(res)
        }
        if let err = response.error {
            error(err)
        }
    }
}

func getTopTracks(timeRange: String, callback: @escaping (_ tracks: [Track]) -> Void) {
    let headers: HTTPHeaders = [
        .authorization(bearerToken: User.shared.accessToken),
        .accept("application/json")
    ]
    AF.request("http://localhost:8080/api/top?time_range=\(timeRange)", headers: headers).validate().responseDecodable(of: TrackResponse.self) { response in
        debugPrint("Response: \(response)")
        if let res = response.value {
            callback(res.items)
        }
    }
}
