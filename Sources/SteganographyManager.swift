//
//  SteganographyManager.swift
//  SteganographyKit
//
//  Created by Caio Franca on 18 de dez. de 2023.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import UIKit

public struct RGBA32: Equatable {
    var color: UInt32
    
    var red: UInt8 {
        get { return UInt8((color >> 24) & 255) }
        set { color = (color & 0xFFFFFF) | (UInt32(newValue) << 24) }
    }
    
    static let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
}

public class SteganographyManager {
    
    public init() {}
    
    public static func hideMessageInImage(image: UIImage, message: String) -> UIImage? {
        guard let inputCGImage = image.cgImage else { return nil }
        let bitmapData = createBitmap(from: inputCGImage)
        
        var bitIndex = 0
        let messageBits = message.utf8.flatMap { byte -> [Bool] in
            return (0..<8).map { i in
                return (byte >> i) & 1 == 1
            }
        }
        
        for y in 0..<bitmapData.height {
            for x in 0..<bitmapData.width {
                let pixelIndex = y * bitmapData.width + x
                var pixel = bitmapData.buffer[pixelIndex]
                
                if bitIndex < messageBits.count {
                    if messageBits[bitIndex] {
                        pixel.red |= 1 // Set the least significant bit
                    } else {
                        pixel.red &= ~1 // Clear the least significant bit
                    }
                    bitIndex += 1
                }
                
                bitmapData.buffer[pixelIndex] = pixel
            }
        }
        
        return bitmapData.context.makeImage().flatMap { UIImage(cgImage: $0, scale: image.scale, orientation: image.imageOrientation) }
    }
    
    public static func readMessageFromImage(image: UIImage) -> String? {
        guard let inputCGImage = image.cgImage else { return nil }
        let bitmapData = createBitmap(from: inputCGImage)
        
        var messageBits: [Bool] = []
        for y in 0..<bitmapData.height {
            for x in 0..<bitmapData.width {
                let pixelIndex = y * bitmapData.width + x
                let pixel = bitmapData.buffer[pixelIndex]
                let leastSignificantBit = Int(pixel.red & 1)
                messageBits.append(leastSignificantBit == 1)
            }
        }
        
        var message = ""
        for i in stride(from: 0, to: messageBits.count, by: 8) {
            let byteBits = messageBits[i..<min(i + 8, messageBits.count)]
            if byteBits.count < 8 {
                break // Stop if we don't have enough bits for a full byte
            }
            let byte = byteBits.enumerated().reduce(0) { (acc, bitInfo) -> UInt8 in
                let (index, bit) = bitInfo
                return acc | (bit ? (1 << index) : 0)
            }
            
            let scalar = UnicodeScalar(byte)
            
            if  scalar != UnicodeScalar(0) {
                message.append(Character(scalar))
            } else {
                break
            }
            
        }
        
        return message
    }
    
    private static func createBitmap(from cgImage: CGImage) -> (context: CGContext, buffer: UnsafeMutablePointer<RGBA32>, width: Int, height: Int) {
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerPixel = 4
        let bitsPerComponent = 8
        let bytesPerRow = bytesPerPixel * width
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = RGBA32.bitmapInfo
        
        let context = CGContext(data: nil,
                                width: width,
                                height: height,
                                bitsPerComponent: bitsPerComponent,
                                bytesPerRow: bytesPerRow,
                                space: colorSpace,
                                bitmapInfo: bitmapInfo)!
        
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        let buffer = context.data!.bindMemory(to: RGBA32.self, capacity: width * height)
        return (context, buffer, width, height)
    }
}
