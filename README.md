<p align="center">
   <img width="200" src="https://raw.githubusercontent.com/SvenTiigi/SwiftKit/gh-pages/readMeAssets/SwiftKitLogo.png" alt="SteganographyKit Logo">
</p>

<p align="center">
   <a href="https://developer.apple.com/swift/">
      <img src="https://img.shields.io/badge/Swift-5.2-orange.svg?style=flat" alt="Swift 5.2">
   </a>
   <a href="https://github.com/apple/swift-package-manager">
      <img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" alt="SPM">
   </a>
</p>

# SteganographyKit

<p align="center">
SteganographyKit is an iOS framework designed to seamlessly integrate steganography into mobile applications. It provides developers with a simple and efficient way to embed and extract hidden messages or data within images. Featuring an easy-to-use public interface, the kit ensures secure and subtle data encoding, making it ideal for applications requiring confidentiality, like secure messaging or digital watermarking.
</p>

## Features

- [x] Allows embedding of secret text messages into images without altering their visible appearance.
- [x] Provides the ability to extract hidden messages from images, ensuring data retrieval is as seamless as encoding.
- [x] Ensures that the visual quality of images is not compromised during the steganography process.
- [x] Provides a straightforward and intuitive public API, making it accessible for developers of all skill levels.

## Example

The example application is the best way to see `SteganographyKit` in action. Simply open the `SteganographyKit.xcodeproj` and run the `Example` scheme.

## Installation

### Swift Package Manager

To integrate using Apple's [Swift Package Manager](https://swift.org/package-manager/), add the following as a dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/caiofranca5/SteganographyKit.git", from: "1.0.0")
]
```

## Usage

### How to encode a message in an image

```swift
import SteganographyKit

    /// Encodes a message into an image.
    /// - Parameters:
    ///   - message: The message to be encoded. (String)
    ///   - image: The image in which the message will be encoded. (UIImage)
    /// - Returns: An image with the encoded message or nil if the operation fails.
    
    let imageWithHiddenMessage = SteganographyManager.encodeMessage(message, inImage: image)
    

```

### How to decode a message from an image

```swift
import SteganographyKit

    /// Decodes a message from an image.
    /// - Parameter image: The image containing the encoded message. (UIImage)
    /// - Returns: The decoded message or nil if no message is found or if the operation fails.
    
    let hiddenMessage = SteganographyManager.decodeMessage(fromImage: image)
    

```

## License

SteganographyKit
Copyright (c) 2023 SteganographyKit Caio Franca caiofranca5@hotmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
