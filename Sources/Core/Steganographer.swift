//
//  Steganographer.swift
//  SteganographyKit
//
//  Created by Caio França on 18/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import UIKit

final class Steganographer {
    
    // MARK: - Encode Message
    
    static func hideMessageInImage(image: UIImage, message: String) -> UIImage? {
        guard let inputCGImage = image.cgImage else { return nil }
        
        let bitmapData = createBitmap(from: inputCGImage)
        
        let messageWithSpecialFinalCharacter = message + "\0"
        
        var messageBits = [Bool]()
        for char in messageWithSpecialFinalCharacter.utf8 {
            for i in 0..<8 {
                let bit = (char >> i) & 1
                messageBits.append(bit == 1)
            }
        }
        
        var bitIndex = 0
        
        for y in 0..<bitmapData.height {
            for x in 0..<bitmapData.width {
                let pixelIndex = y * bitmapData.width + x
                var pixel = bitmapData.buffer[pixelIndex]
                
                if bitIndex < messageBits.count {
                    if messageBits[bitIndex] {
                        pixel.red |= 1
                    } else {
                        pixel.red &= ~1
                    }
                    bitIndex += 1
                }
                
                bitmapData.buffer[pixelIndex] = pixel
            }
        }
        
        if let newCGImage = bitmapData.context.makeImage() {
            return UIImage(cgImage: newCGImage, scale: image.scale, orientation: image.imageOrientation)
        }
        
        return nil
    }
    
    // MARK: - Decode Message
    
    static func readMessageFromImage(image: UIImage) -> String? {
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
                break
            }
            
            var byte: UInt8 = 0
            for (index, bit) in byteBits.enumerated() {
                if bit {
                    byte |= 1 << index
                }
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

    // MARK: - Create Bitmap
    
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
