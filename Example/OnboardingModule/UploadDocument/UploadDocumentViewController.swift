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
    private lazy var imagePicker = UIImagePickerController()
    
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
        viewModel.delegate = self
        contentView.delegate = self
        imagePicker.delegate = self
    }
    
}

// MARK: - View Delegate

extension UploadDocumentViewController: UploadDocumentViewDelegate {
    
    func didTapContinue() {
        self.view = LoadingView()
        self.navigationController?.navigationBar.isHidden = true
        viewModel.sendUserData()
    }
    
    func didTapUpload() {
        present(imagePicker, animated: true)
    }
    
}

// MARK: - ViewModel Delegate

extension UploadDocumentViewController: OnboardingViewModelDelegate {
    
    func didUploadData() {
        coordinator?.presentFeedbackView(feedback: .success)
    }
    
    func didNotUploadData(error: Error) {
        coordinator?.presentFeedbackView(feedback: .failure(error))
    }

}

// MARK: - UIImagePickerControllerDelegate

extension UploadDocumentViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            contentView.imageView.image = selectedImage
            viewModel.fillDocument(documentImage: selectedImage)
            contentView.continueButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
}
