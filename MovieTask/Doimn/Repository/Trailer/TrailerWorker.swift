//
//  TrailerWorker.swift
//  MovieTask
//
//  Created by Al-attar on 31/03/2024.
//

import Foundation

enum TrailerNetworking: TargetType {
    case trailer(id: Int)
}

extension TrailerNetworking {
    var path: String {
        switch self {
        case .trailer(let id):
            return "movie/\(id)/videos"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .trailer:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .trailer:
            return .requestPlain
        }
    }
    
    var headers: [String : String] {
        return [:]
    }
}
