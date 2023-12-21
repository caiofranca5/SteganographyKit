//
//  AppDelegate.swift
//  Example
//
//  Created by Caio França on 20/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: OnboardingCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = .init(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        coordinator = OnboardingCoordinator(navigationController: navigationController)
        coordinator?.start()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }

}
