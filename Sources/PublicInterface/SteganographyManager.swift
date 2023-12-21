//
//  SteganographyManager.swift
//  SteganographyKit-iOS
//
//  Created by Caio França on 20/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import UIKit

public class SteganographyManager {

    // MARK: - Public Methods

    /// Encodes a message into an image.
    /// - Parameters:
    ///   - message: The message to be encoded.
    ///   - image: The image in which the message will be encoded.
    /// - Returns: An image with the encoded message or nil if the operation fails.
    @objc public static func encodeMessage(_ message: String, inImage image: UIImage) -> UIImage? {
        return Steganographer.hideMessageInImage(image: image, message: message)
    }

    /// Decodes a message from an image.
    /// - Parameter image: The image containing the encoded message.
    /// - Returns: The decoded message or nil if no message is found or if the operation fails.
    @objc public static func decodeMessage(fromImage image: UIImage) -> String? {
        return Steganographer.readMessageFromImage(image: image)
    }

}
