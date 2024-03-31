//
//  CastWorker.swift
//  MovieTask
//
//  Created by Al-attar on 31/03/2024.
//

import Foundation

enum CastNetworking: TargetType {
    case cast(id: Int)
}

extension CastNetworking {
    var path: String {
        switch self {
        case .cast(let id):
            return "movie/\(id)/credits"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .cast:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .cast:
            return .requestPlain
        }
    }
    
    var headers: [String : String] {
        return [:]
    }
}


