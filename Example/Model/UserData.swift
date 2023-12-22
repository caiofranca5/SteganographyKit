//
//  UserData.swift
//  Example
//
//  Created by Caio França on 22/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import Foundation

struct UserData: Codable {
    let name: String
    let birthday: String
    let documentImageBase64: String?
}
