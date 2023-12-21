//
//  UploadDocumentViewController.swift
//  Example
//
//  Created by Caio França on 21/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import UIKit

class UploadDocumentViewController: UIViewController {

    // MARK: - Properties
    weak var coordinator: OnboardingCoordinator?
    private lazy var contentView = UploadDocumentView()
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

extension UploadDocumentViewController: UploadDocumentViewDelegate {
    
    func didTapContinue() {
        coordinator?.navigationController.popToRootViewController(animated: true)
    }
    
}
