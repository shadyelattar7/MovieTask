//
//  NowPlayingViewModelTests.swift
//  MovieTaskTests
//
//  Created by Al-attar on 31/03/2024.
//

import XCTest
@testable import MovieTask

final class NowPlayingViewModelTests: XCTestCase {
    
    func testGivenNoMovies_WhenViewModelLoads_ThenNumberOfMoviesIsZero() {
        // Given
        let mockMoviesRepo = MockMovieWorker()
        let viewModel = NowPlayingViewModel(movies: mockMoviesRepo)
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertEqual(viewModel.numberOfMovies(), 0, "Number of movies should be zero when no movies are loaded")
    }
    
    func testGivenMoviesLoaded_WhenViewModelLoads_ThenNumberOfMoviesIsCorrect() {
        // Given
        let mockMoviesRepo = MockMovieWorker()
        let dummyMovies: [MovieData] = [
            MovieData(
                id: 1,
                title: "Movie 1",
                overview: "Overview 1",
                poster_path: nil,
                backdrop_path: nil,
                vote_average: 7.5,
                release_date: "2022-03-01",
                original_title: "Original Title 1"
            ),
            MovieData(
                id: 2,
                title: "Movie 2",
                overview: "Overview 2",
                poster_path: nil,
                backdrop_path: nil,
                vote_average: 8.0,
                release_date: "2022-04-01",
                original_title: "Original Title 2"
            )
        ]
        mockMoviesRepo.dummyMovies = dummyMovies
        let viewModel = NowPlayingViewModel(movies: mockMoviesRepo)
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertEqual(viewModel.numberOfMovies(), dummyMovies.count, "Number of movies should match the count of loaded movies")
    }
    
    func testGivenNoMovies_WhenViewModelLoads_ThenGetNowPlayingIsCalled() {
        // Given
        let mockMoviesRepo = MockMovieWorker()
        let viewModel = NowPlayingViewModel(movies: mockMoviesRepo)
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockMoviesRepo.nowPlayingCalled, "getNowPlaying should be called when ViewModel loads")
    }
}

class MockMovieWorker: MovieWorkerProtocol {

    var nowPlayingCalled = false
    var dummyMovies: [MovieData] = []
    
    func nowPlaying(completion: @escaping (Result<MovieResponse, APIError>) -> Void) {
        nowPlayingCalled = true
        // Return a predefined MovieResponse for testing
        let dummyResponse = MovieResponse(results: dummyMovies)
        completion(.success(dummyResponse))
    }
}
