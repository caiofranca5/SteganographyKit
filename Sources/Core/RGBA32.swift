//
//  RGBA32.swift
//  Example
//
//  Created by Caio França on 22/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import UIKit

struct RGBA32: Equatable {
    var color: UInt32

    var red: UInt8 {
        get {
            let redValue = color >> 24
            return UInt8(redValue)
        }
        set {
            color &= 0xFFFFFF
            let redValue32 = UInt32(newValue) << 24
            color |= redValue32
        }
    }
    
    static let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
}
