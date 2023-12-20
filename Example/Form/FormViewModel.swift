//
//  FormViewModel.swift
//  Example
//
//  Created by Caio França on 20/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import Foundation

class FormViewModel {
    var name = ""
    var birthday = ""
    
    func presentNextStep() {
        print(name)
        print(birthday)
    }
}
