//
//  CastResponse.swift
//  MovieTask
//
//  Created by Al-attar on 31/03/2024.
//

import Foundation

struct CastResponse: Codable{
    var cast: [CastDetails]
}


struct CastDetails: Codable {
    var character: String
    var name: String
    var profile_path: String?
}
