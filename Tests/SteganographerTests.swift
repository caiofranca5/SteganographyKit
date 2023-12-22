//
//  SteganographyKitTests.swift
//  SteganographyKitTests
//
//  Created by Caio França on 20/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

@testable import SteganographyKit
import XCTest

class SteganographerTests: XCTestCase {
    
    var testImage: UIImage!

    override func setUp() {
        super.setUp()
        let testBundle = Bundle(for: type(of: self))
        testImage = UIImage(named: "dog", in: testBundle, compatibleWith: nil)
    }

    override func tearDown() {
        testImage = nil
        super.tearDown()
    }

    func testHideMessageInImage() {
        let message = "Test Message"
        let imageWithHiddenMessage = Steganographer.hideMessageInImage(image: testImage, message: message)
        
        XCTAssertNotNil(imageWithHiddenMessage, "Image with hidden message should not be nil")
    }

    func testReadMessageFromImage() {
        let originalMessage = "Test Message"
        let imageWithHiddenMessage = Steganographer.hideMessageInImage(image: testImage, message: originalMessage)
        let recoveredMessage = Steganographer.readMessageFromImage(image: imageWithHiddenMessage!)
        
        XCTAssertEqual(recoveredMessage, originalMessage, "Recovered message should match the original")
    }

    func testBehaviorWithNilImage() {
        let message = "Test Message"
        let imageWithHiddenMessage = Steganographer.hideMessageInImage(image: UIImage(), message: message)

        XCTAssertNil(imageWithHiddenMessage, "Result should be nil for a nil image")
    }

    func testBehaviorWithEmptyMessage() {
        let imageWithHiddenMessage = Steganographer.hideMessageInImage(image: testImage, message: "")
        let recoveredMessage = Steganographer.readMessageFromImage(image: imageWithHiddenMessage!)

        XCTAssertEqual(recoveredMessage, "", "Recovered message should be empty for an empty original message")
    }
    
    func testReadMessageFromImageAfterJPEGCompression() {
        let originalMessage = "Test Message"
        guard let imageWithHiddenMessage = Steganographer.hideMessageInImage(image: testImage, message: originalMessage) else {
            XCTFail("Failed to hide message in image")
            return
        }

        guard let jpegData = imageWithHiddenMessage.jpegData(compressionQuality: 0.5),
              let compressedImage = UIImage(data: jpegData) else {
            XCTFail("Failed to compress and decompress image")
            return
        }

        let recoveredMessage = Steganographer.readMessageFromImage(image: compressedImage)

        XCTAssertNotEqual(recoveredMessage, originalMessage, "Recovered message should not match the original")
    }
    
    func testReadMessageFromImageAfterTransformingToPNGData() {
        let originalMessage = "Test Message"
        guard let imageWithHiddenMessage = Steganographer.hideMessageInImage(image: testImage, message: originalMessage) else {
            XCTFail("Failed to hide message in image")
            return
        }

        guard let pngData = imageWithHiddenMessage.pngData(),
              let compressedImage = UIImage(data: pngData) else {
            XCTFail("Failed to compress and decompress image")
            return
        }
        
        let recoveredMessage = Steganographer.readMessageFromImage(image: compressedImage)
        XCTAssertEqual(recoveredMessage, originalMessage, "Recovered message should match the original")
    }

}
