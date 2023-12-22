//
//  SuccessResponse.swift
//  Example
//
//  Created by Caio França on 22/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import Foundation

struct SuccessResponse: Decodable {
    var status: String
    var message: String
    var data: SuccessData?
    
    struct SuccessData: Decodable {
        var userId: String
        var timestamp: String
    }
}
