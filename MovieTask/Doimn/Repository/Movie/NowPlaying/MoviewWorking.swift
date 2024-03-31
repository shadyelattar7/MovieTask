//
//  MoviewWorking.swift
//  MovieTask
//
//  Created by Al-attar on 26/03/2024.
//

import Foundation

protocol MovieWorkerProtocol{
    
    /// it is the method used to get now playing movie
    /// - Parameters:
    ///   - params:
    /// - Returns: movie model
    func nowPlaying(completion: @escaping (Result<MovieResponse, APIError>) -> Void)
    
    /// it is the method used to get popular movie
    /// - Parameters:
    ///   - params:
    /// - Returns: movie model
    func popular(completion: @escaping (Result<MovieResponse, APIError>) -> Void)
    
    /// it is the method used to get upcoming movie
    /// - Parameters:
    ///   - params:
    /// - Returns: movie model
    func upcoming(completion: @escaping (Result<MovieResponse, APIError>) -> Void)
}


class MovieWorker: APIClient<MovieNetworking>, MovieWorkerProtocol {
    private let movieCache = MovieCache.shared
    
    func nowPlaying(completion: @escaping (Result<MovieResponse, APIError>) -> Void) {
        self.performRequest(target: .nowPlaying) { [weak self] (result: Result<MovieResponse, APIError>) in
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
