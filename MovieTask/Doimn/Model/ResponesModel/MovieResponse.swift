//
//  MovieResponse.swift
//  MovieTask
//
//  Created by Al-attar on 26/03/2024.
//

import Foundation

struct MovieResponse: Codable {
    let results: [MovieData]
}

struct MovieData: Codable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
    let vote_average: Double
    let release_date: String
    let original_title: String
}
