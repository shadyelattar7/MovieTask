//
//  MovieDetailsViewModelTests.swift
//  MovieTaskTests
//
//  Created by Al-attar on 31/03/2024.
//

import XCTest
@testable import MovieTask

class MovieDetailsViewModelTests: XCTestCase {
    
    // MARK: - Test Doubles
    
    class MockTrailerWorker: TrailerWorkerProtocol {
        var shouldSucceed: Bool = true
        
        func trailer(id: Int, completion: @escaping (Result<TrailerResponse, APIError>) -> Void) {
            if shouldSucceed {
                // Simulate a successful response
                let trailers = TrailerResponse(
                    results: [
                        VideoDetails(
                            key: "abc"
                        )
                    ]
                )
                completion(.success(trailers))
            } else {
                // Simulate a failure response
                completion(.failure(.networkError("Mock error")))
            }
        }
    }
    
    class MockCastWorker: CastWorkerProtocol {
        var shouldSucceed: Bool = true
        
        func cast(id: Int, completion: @escaping (Result<CastResponse, APIError>) -> Void) {
            if shouldSucceed {
                // Simulate a successful response
                let cast = CastResponse(
                    cast: [
                        CastDetails(
                            character: "Character 1",
                            name: "Actor 1",
                            profile_path: nil
                        )]
                )
                completion(.success(cast))
            } else {
                // Simulate a failure response
                completion(.failure(.networkError("Mock error")))
            }
        }
    }
    
    class MockGenresWorker: GenresWorkerProtocol {
        var shouldSucceed: Bool = true
        
        func genres(id: Int, completion: @escaping (Result<GenresResponse, APIError>) -> Void) {
            if shouldSucceed {
                // Simulate a successful response
                let genres = GenresResponse(genres: [GenresDetails(name: "Genre 1")])
                completion(.success(genres))
            } else {
                // Simulate a failure response
                completion(.failure(.networkError("Mock error")))
            }
        }
    }
    
    // MARK: - Properties
    
    var viewModel: MovieDetailsViewModel!
    var mockTrailerWorker: MockTrailerWorker!
    var mockCastWorker: MockCastWorker!
    var mockGenresWorker: MockGenresWorker!
    
    // MARK: - Setup and Teardown
    
    override func setUp() {
        super.setUp()
        mockTrailerWorker = MockTrailerWorker()
        mockCastWorker = MockCastWorker()
        mockGenresWorker = MockGenresWorker()
        viewModel = MovieDetailsViewModel(
            movieDetails: MovieDetailsModel(
                id: 1,
                title: "Movie 1",
                overview: "",
                poster_path: nil,
                vote_average: 8.0
            ),
            trailerRepo: mockTrailerWorker,
            castRepo: mockCastWorker,
            genresRepo: mockGenresWorker
        )
    }
    
    override func tearDown() {
        viewModel = nil
        mockTrailerWorker = nil
        mockCastWorker = nil
        mockGenresWorker = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func testNumberOfCharacters() {
        // Given
        viewModel.cast.value = [
            CastDetails(
                character: "Character 1", 
                name: "Actor 1",
                profile_path: nil
            ),
            CastDetails(
                character: "Character 2", 
                name: "Actor 2",
                profile_path: nil
            )
        ]
        
        // When
        let count = viewModel.numberOfChartacters()
        
        // Then
        XCTAssertEqual(count, 2, "Number of characters should match the count of cast members in the view model")
    }
    
    func testGetTrailerSuccess() {
        // Given
        mockTrailerWorker.shouldSucceed = true
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertEqual(viewModel.trailer.value.count, 1, "Number of trailers should be updated after successful API call")
    }
    
    func testGetTrailerFailure() {
        // Given
        mockTrailerWorker.shouldSucceed = false
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertEqual(viewModel.trailer.value.count, 0, "Number of trailers should not change after failed API call")
    }
}
