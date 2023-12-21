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
    private let viewModel = FormViewModel()
    private lazy var contentView = FormView()
    
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

extension FormViewController: FormViewDelegate {
    
    func didTapContinue() {
        viewModel.presentNextStep()
        coordinator?.presentUploadDocumentView()
    }
    
}

extension FormViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == contentView.nameTextfield {
            contentView.birthdayTextfield.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        if contentView.nameTextfield.text != "" && contentView.birthdayTextfield.text != "" {
            contentView.continueButton.isEnabled = true
        } else {
            contentView.continueButton.isEnabled = false
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == contentView.nameTextfield {
            viewModel.name = textField.text ?? ""
        } else {
            viewModel.birthday = textField.text ?? ""
        }
        return true
    }
    
}
