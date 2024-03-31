//
//  GenresWorking.swift
//  MovieTask
//
//  Created by Al-attar on 31/03/2024.
//

import Foundation

protocol GenresWorkerProtocol{
    
    /// it is the method used to get genres movie
    /// - Parameters:
    ///   - params:
    /// - Returns: genres model
    func genres(id: Int, completion: @escaping (Result<GenresResponse, APIError>) -> Void)
    
}


class GenresWorker: APIClient<GenresNetworking>, GenresWorkerProtocol{
    func genres(id: Int, completion: @escaping (Result<GenresResponse, APIError>) -> Void) {
        self.performRequest(target: .genres(id: id)) { result in
            completion(result)
        }
    }
}
