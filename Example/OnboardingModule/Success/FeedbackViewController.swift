//
//  FeedbackViewController.swift
//  Example
//
//  Created by Caio França on 22/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    // MARK: - Properties
    weak var coordinator: OnboardingCoordinator?
    private lazy var contentView = TemplateView()
    private let viewModel: OnboardingViewModel
    private let feedback: Feedback
    
    // MARK: - Init
    init(viewModel: OnboardingViewModel, feedback: Feedback) {
        self.viewModel = viewModel
        self.feedback = feedback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Controller Life Cycle
    
    override func loadView() {
        super.loadView()
        switch feedback {
        case .success:
            contentView.updateViewWith(newImage: "Success",
                                       newTitle: "Congratulations",
                                       newSubtitle: "Your document ID, containing a hidden message, has been successfully uploaded.",
                                       newButtonTitle: "Restart")
        case .failure(let error):
            print(error.localizedDescription)
            contentView.updateViewWith(newImage: "Failure",
                                       newTitle: "Oops!",
                                       newSubtitle: "Upload could not be processed because the file size exceeds our server's limits (Error 413: Payload Too Large). Please reduce the file size and try uploading again.",
                                       newButtonTitle: "Restart")
        }
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
    }

}

extension FeedbackViewController: TemplateViewDelegate {
    
    func didTapContinue() {
        coordinator?.restart()
    }
    
}
