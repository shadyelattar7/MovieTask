//
//  GenresWorker.swift
//  MovieTask
//
//  Created by Al-attar on 31/03/2024.
//

import Foundation

enum GenresNetworking: TargetType {
    case genres(id: Int)
}

extension GenresNetworking {
    var path: String {
        switch self {
        case .genres(let id):
            return "movie/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .genres:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .genres:
            return .requestPlain
        }
    }
    
    var headers: [String : String] {
        return [:]
    }
}
