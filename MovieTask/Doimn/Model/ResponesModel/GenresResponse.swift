//
//  GenresResponse.swift
//  MovieTask
//
//  Created by Al-attar on 31/03/2024.
//

import Foundation

struct GenresResponse: Codable {
    let genres: [GenresDetails]
}

struct GenresDetails: Codable{
    let name: String
}
