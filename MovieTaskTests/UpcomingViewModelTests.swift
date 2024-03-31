//
//  UpcomingViewModelTests.swift
//  MovieTaskTests
//
//  Created by Al-attar on 31/03/2024.
//

import XCTest
@testable import MovieTask

class UpcomingViewModelTests: XCTestCase {
    
    // MARK: - Test Doubles
    
    class MockUpcomingWorker: UpcomingWorkerProtocol {
        var shouldSucceed: Bool = true
        
        func upcoming(completion: @escaping (Result<MovieResponse, APIError>) -> Void) {
            if shouldSucceed {
                // Simulate a successful response
                let movies = MovieResponse(
                    results: [MovieData(
                        id: 1,
                        title: "Movie 1",
                        overview: "",
                        poster_path: nil,
                        backdrop_path: nil,
                        vote_average: 7.5,
                        release_date: "2023-01-01",
                        original_title: ""
                    )]
                )
                completion(.success(movies))
            } else {
                // Simulate a failure response
                completion(.failure(.networkError("Mock error")))
            }
        }
    }
    
    // MARK: - Properties
    
    var viewModel: UpcomingViewModel!
    var mockWorker: MockUpcomingWorker!
    
    // MARK: - Setup and Teardown
    
    override func setUp() {
        super.setUp()
        mockWorker = MockUpcomingWorker()
        viewModel = UpcomingViewModel(movies: mockWorker)
    }
    
    override func tearDown() {
        viewModel = nil
        mockWorker = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func testNumberOfMovies() {
        // Given
        viewModel.movies.value = [
            MovieData(
                id: 1,
                title: "Movie 1",
                overview: "",
                poster_path: nil,
                backdrop_path: nil,
                vote_average: 7.5,
                release_date: "2023-01-01",
                original_title: ""
            ),
            MovieData(
                id: 2,
                title: "Movie 2",
                overview: "",
                poster_path: nil,
                backdrop_path: nil,
                vote_average: 8.0,
                release_date: "2023-01-02",
                original_title: ""
            )
        ]
        
        // When
        let count = viewModel.numberOfMovies()
        
        // Then
        XCTAssertEqual(count, 2, "Number of movies should match the count of movies in the view model")
    }
    
    func testGetUpcomingSuccess() {
        // Given
        mockWorker.shouldSucceed = true
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertEqual(viewModel.numberOfMovies(), 1, "Number of movies should be updated after successful API call")
    }
    
    func testGetUpcomingFailure() {
        // Given
        mockWorker.shouldSucceed = false
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertEqual(viewModel.numberOfMovies(), 0, "Number of movies should not change after failed API call")
    }    
}
