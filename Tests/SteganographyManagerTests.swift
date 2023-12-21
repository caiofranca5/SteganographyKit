//
//  SteganographyManagerTests.swift
//  SteganographyKit-iOSTests
//
//  Created by Caio França on 21/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

@testable import SteganographyKit
import XCTest

final class SteganographyManagerTests: XCTestCase {

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

    func testEncodeMessage() {
        let message = "Test Message"
        let imageWithHiddenMessage = SteganographyManager.encodeMessage(message, inImage: testImage)
        
        XCTAssertNotNil(imageWithHiddenMessage, "Image with hidden message should not be nil")
    }

    func testDecode() {
        let originalMessage = "Test Message"
        let imageWithHiddenMessage = SteganographyManager.encodeMessage(originalMessage, inImage: testImage)
        let recoveredMessage = SteganographyManager.decodeMessage(fromImage: imageWithHiddenMessage ?? UIImage())
        
        XCTAssertEqual(recoveredMessage, originalMessage, "Recovered message should match the original")
    }
    
}
