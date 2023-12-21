//
//  OnboardingViewModel.swift
//  Example
//
//  Created by Caio França on 20/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import UIKit

class OnboardingViewModel {
    var name: String?
    var birthday: String?
    var document: UIImage?
    
    func presentNextStep() {
        print(name ?? "")
        print(birthday ?? "")
    }
}
