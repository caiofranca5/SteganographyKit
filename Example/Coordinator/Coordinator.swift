//
//  Coordinator.swift
//  Example
//
//  Created by Caio França on 20/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class OnboardingCoordinator: Coordinator {
    var navigationController: UINavigationController
    let onboardingViewModel = OnboardingViewModel()
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.navigationController.navigationBar.tintColor = .systemRed
    }
    
    func start() {
        let viewController = WelcomeViewController(viewModel: onboardingViewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func presentFormView() {
        let viewController = FormViewController(viewModel: onboardingViewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentUploadDocumentView() {
        let viewController = UploadDocumentViewController(viewModel: onboardingViewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func restart() {
        navigationController.popToRootViewController(animated: true)
    }
}
