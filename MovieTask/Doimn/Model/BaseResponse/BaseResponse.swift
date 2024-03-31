//
//  BaseResponse.swift
//  MovieTask
//
//  Created by Al-attar on 26/03/2024.
//

import Foundation

class BaseResponseGen<T: Codable>: Codable{
    
    let status: Bool?
    let message: String?
    let code: Int?
    let token: String?
    let messages: [String]?
    let errors: [String]?
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case status = "status"
        case data =  "data"
        case messages = "messages"
        case errors = "errors"
        case code = "code"
        case token = "token"
    }
}

struct BaseResponse : Codable {
    let status : Bool?
    let code : Int?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case code = "code"
        case message = "message"
    }

}

