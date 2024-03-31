//
//  CastWorking.swift
//  MovieTask
//
//  Created by Al-attar on 31/03/2024.
//

import Foundation

protocol CastWorkerProtocol{
    
    /// it is the method used to get cast movie
    /// - Parameters:
    ///   - params:
    /// - Returns: cast model
    func cast(id: Int, completion: @escaping (Result<CastResponse, APIError>) -> Void)
    
}


class CastWorker: APIClient<CastNetworking>, CastWorkerProtocol{
    func cast(id: Int, completion: @escaping (Result<CastResponse, APIError>) -> Void) {
        self.performRequest(target: .cast(id: id)) { result in
            completion(result)
        }
    }
}
