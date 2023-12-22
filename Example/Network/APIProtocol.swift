//
//  APIProtocol.swift
//  Example
//
//  Created by Caio França on 21/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import Foundation

protocol API {
    var scheme: HTTPScheme { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: HTTPMethod { get }
    var requestBody: Data? { get }
}
