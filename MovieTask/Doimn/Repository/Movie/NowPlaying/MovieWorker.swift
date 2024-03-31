//
//  MovieWorker.swift
//  MovieTask
//
//  Created by Al-attar on 26/03/2024.
//

import Foundation

enum MovieNetworking: TargetType {
    case nowPlaying
}

extension MovieNetworking {
    var path: String {
        switch self {
        case .nowPlaying:
            return "discover/movie"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .nowPlaying:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .nowPlaying:
            return .requestPlain
        }
    }
    
    var headers: [String : String] {
        return [:]
    }
}
