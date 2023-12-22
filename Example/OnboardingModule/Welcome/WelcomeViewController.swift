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
    private lazy var contentView = TemplateView()
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
        contentView.updateViewWith(newImage: "WelcomeImage",
                                   newTitle: "Welcome to a World of Possibilities.",
                                   newSubtitle: "Create your account today: provide personal information, upload an ID Document for security, and begin exploring.",
                                   newButtonTitle: "Get Started")
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension WelcomeViewController: TemplateViewDelegate {
    
    func didTapContinue() {
        coordinator?.presentFormView()
    }
    
}
