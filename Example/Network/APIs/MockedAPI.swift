//
//  MockedAPI.swift
//  Example
//
//  Created by Caio França on 21/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import Foundation

enum MockedAPI: API {
    case createUser(UserData)
    
    var scheme: HTTPScheme {
        return .https
    }
    
    var baseURL: String {
        return "api.mocki.io"
        
    }
    
    var path: String {
        switch self {
        case .createUser:
            return "/v2/d3b33e54/create-user"
        }
    }
    
    var parameters: [URLQueryItem] {
        return []
    }
    
    var method: HTTPMethod {
        switch self {
        case .createUser:
            return .post
        }
    }
    
    var requestBody: Data? {
        switch self {
        case .createUser(let userData):
            return try? JSONEncoder().encode(userData)
        }
    }
}

