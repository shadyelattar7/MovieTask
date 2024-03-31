//
//  UpcomingWorker.swift
//  MovieTask
//
//  Created by Al-attar on 31/03/2024.
//

import Foundation

enum UpcomingNetworking: TargetType {
    case upcoming
}

extension UpcomingNetworking {
    var path: String {
        switch self {
        case .upcoming:
            return "movie/upcoming"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .upcoming:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .upcoming:
            return .requestPlain
        }
    }
    
    var headers: [String : String] {
        return [:]
    }
}
