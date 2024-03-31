//
//  UpcomingWorking.swift
//  MovieTask
//
//  Created by Al-attar on 31/03/2024.
//

import Foundation

protocol UpcomingWorkerProtocol{
    
    /// it is the method used to get upcoming movie
    /// - Parameters:
    ///   - params:
    /// - Returns: movie model
    func upcoming(completion: @escaping (Result<MovieResponse, APIError>) -> Void)
}


class UpcomingWorker: APIClient<UpcomingNetworking>, UpcomingWorkerProtocol {
    private let movieCache = MovieCache.shared
    
    func upcoming(completion: @escaping (Result<MovieResponse, APIError>) -> Void) {
        self.performRequest(target: .upcoming) { [weak self] (result: Result<MovieResponse, APIError>) in
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
