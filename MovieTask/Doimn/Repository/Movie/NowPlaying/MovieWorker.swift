//
//  MovieWorker.swift
//  MovieTask
//
//  Created by Al-attar on 26/03/2024.
//

import Foundation

enum MovieNetworking: TargetType {
    case nowPlaying
    case popular
    case upcoming
}

extension MovieNetworking {
    var path: String {
        switch self {
        case .nowPlaying:
            return "movie/now_playing"
        case .popular:
            return "movie/popular"
        case .upcoming:
            return "movie/upcoming"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .nowPlaying:
            return .get
        case .popular:
            return .get
        case .upcoming:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .nowPlaying:
            return .requestPlain
        case .popular:
            return .requestPlain
        case .upcoming:
            return .requestPlain
        }
    }
    
    var headers: [String : String] {
        return [:]
    }
}
