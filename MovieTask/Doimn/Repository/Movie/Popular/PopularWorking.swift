//
//  PopularWorking.swift
//  MovieTask
//
//  Created by Al-attar on 31/03/2024.
//

import Foundation

protocol PopularWorkerProtocol{
    
    /// it is the method used to get popular movie
    /// - Parameters:
    ///   - params:
    /// - Returns: movie model
    func popular(completion: @escaping (Result<MovieResponse, APIError>) -> Void)
}


class PopularWorker: APIClient<PopularNetworking>, PopularWorkerProtocol {
    private let movieCache = MovieCache.shared
    
    func popular(completion: @escaping (Result<MovieResponse, APIError>) -> Void) {
        self.performRequest(target: .popular) { [weak self] (result: Result<MovieResponse, APIError>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.movieCache.saveMovies(response.results)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
