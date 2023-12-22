//
//  FormViewController.swift
//  Example
//
//  Created by Caio França on 20/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    // MARK: - Properties
    weak var coordinator: OnboardingCoordinator?
    private let viewModel: OnboardingViewModel
    private lazy var contentView = FormView()
    
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
        contentView.nameTextfield.delegate = self
        contentView.birthdayTextfield.delegate = self
    }
    
}

// MARK: - View Delegate

extension FormViewController: FormViewDelegate {
    
    func didTapContinue() {
        if let name = contentView.nameTextfield.text, let birthday = contentView.birthdayTextfield.text {
            viewModel.fillNameAndBirthday(name: name, birthday: birthday)
            coordinator?.presentUploadDocumentView()
        }
    }
    
}

// MARK: - UITextFieldDelegate

extension FormViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == contentView.nameTextfield {
            contentView.birthdayTextfield.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if contentView.nameTextfield.text != "" && contentView.birthdayTextfield.text != "" {
            contentView.continueButton.isEnabled = true
        } else {
            contentView.continueButton.isEnabled = false
        }
    }
    
}
