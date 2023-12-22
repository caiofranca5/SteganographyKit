//
//  SuccessViewController.swift
//  Example
//
//  Created by Caio França on 22/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

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
        contentView.updateViewWith(newImage: "Success",
                                   newTitle: "Congratulations",
                                   newSubtitle: "Your document ID, containing a hidden message, has been successfully uploaded.",
                                   newButtonTitle: "Restart")
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
    }

}

extension SuccessViewController: TemplateViewDelegate {
    
    func didTapContinue() {
        coordinator?.restart()
    }
    
}
