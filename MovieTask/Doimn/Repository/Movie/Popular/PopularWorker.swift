//
//  PopularWorker.swift
//  MovieTask
//
//  Created by Al-attar on 31/03/2024.
//

import Foundation

enum PopularNetworking: TargetType {
    case popular
}

extension PopularNetworking {
    var path: String {
        switch self {
        case .popular:
            return "movie/popular"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .popular:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .popular:
            return .requestPlain
        }
    }
    
    var headers: [String : String] {
        return [:]
    }
}
