//
//  WelcomeViewController.swift
//  Example
//
//  Created by Caio França on 20/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import UIKit
import SteganographyKit

class WelcomeViewController: UIViewController {

    // MARK: - Properties
    weak var coordinator: OnboardingCoordinator?
    private lazy var contentView = WelcomeView()
    private let viewModel: OnboardingViewModel
    
    // MARK: - Init
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Controller Life Cycle
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
    }

}

extension WelcomeViewController: WelcomeViewDelegate {
    
    func didTapContinue() {
        coordinator?.presentFormView()
    }
    
}
