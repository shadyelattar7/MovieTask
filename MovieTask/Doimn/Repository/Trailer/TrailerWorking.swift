//
//  TrailerWokering.swift
//  MovieTask
//
//  Created by Al-attar on 31/03/2024.
//

import Foundation

protocol TrailerWorkerProtocol{
    
    /// it is the method used to get trailer movie
    /// - Parameters:
    ///   - params:
    /// - Returns: trailer model
    func trailer(id: Int, completion: @escaping (Result<TrailerResponse, APIError>) -> Void)
    
}


class TrailerWorker: APIClient<TrailerNetworking>, TrailerWorkerProtocol{
    func trailer(id: Int, completion: @escaping (Result<TrailerResponse, APIError>) -> Void) {
        self.performRequest(target: .trailer(id: id)) { result in
            completion(result)
        }
    }
}
