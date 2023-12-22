//
//  OnboardingViewModel.swift
//  Example
//
//  Created by Caio França on 20/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import UIKit
import SteganographyKit

class OnboardingViewModel {
    var userName: String?
    var userBirthday: String?
    var userDocumentImage: UIImage?
    let networkManager: NetworkManagerProtocol
    var successResponse: SuccessResponse?
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fillNameAndBirthday(name: String, birthday: String) {
        self.userName = name
        self.userBirthday = birthday
    }
    
    func fillDocument(documentImage: UIImage) {
        self.userDocumentImage = documentImage
    }
    
    func createDcumentImageWithEncodedMessage() -> UIImage? {
        guard let name = userName, let birthday = userBirthday, let document = userDocumentImage else { return nil }
        
        let message = name + birthday
        let imageWithEncodedMessage = SteganographyManager.encodeMessage(message, inImage: document)
        return imageWithEncodedMessage
    }
    
    func sendUserData() {
        if let name = userName, let birthday = userBirthday {
            let document = createDcumentImageWithEncodedMessage()
            let userData = UserData(name: name,
                                    birthday: birthday,
                                    documentImageBase64: "") //document?.pngData()?.base64EncodedString())
            let endpoint: API = MockedAPI.createUser(userData)
            
            networkManager.request(endpoint: endpoint) { [weak self]
                (result: Result<SuccessResponse, Error>) in
                switch result {
                case .success(let response):
                    self?.successResponse = response
                    print(response)
                case .failure(let error):
                    print(error)
                }
            }

        }
    }
}
