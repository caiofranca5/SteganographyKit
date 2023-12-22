//
//  CreateAccountView.swift
//  Example
//
//  Created by Caio França on 20/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import UIKit

protocol FormViewDelegate: AnyObject {
    func didTapContinue()
}

class FormView: UIView {
    
    weak var delegate: FormViewDelegate?
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        label.text = "What's your name?"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "John Doe"
        textfield.tintColor = .systemRed
        textfield.borderStyle = .roundedRect
        textfield.returnKeyType = .next
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var birthdayLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        label.text = "When were you born?"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var birthdayTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "DD/MM/YYYY"
        textfield.tintColor = .systemRed
        textfield.borderStyle = .roundedRect
        textfield.returnKeyType = .done
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    lazy var continueButton: UIButton = {
        var filled = UIButton.Configuration.filled()
        filled.cornerStyle = .large
        filled.baseBackgroundColor = .systemRed
        
        var attText = AttributedString.init("Continue")
        attText.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        filled.attributedTitle = attText
        
        let button = UIButton(configuration: filled, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(continueButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    
    private func setupContentView() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(nameLabel)
        addSubview(nameTextfield)
        addSubview(birthdayLabel)
        addSubview(birthdayTextfield)
        addSubview(continueButton)
    }
    
    private func addConstraints() {
        let margins = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            nameTextfield.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            nameTextfield.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16),
            nameTextfield.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16),
            nameTextfield.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            birthdayLabel.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor, constant: 16),
            birthdayLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16),
            birthdayLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            birthdayTextfield.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 16),
            birthdayTextfield.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16),
            birthdayTextfield.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16),
            birthdayTextfield.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16),
            continueButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
}

//MARK: - View Actions

extension FormView {
    
    @objc func continueButtonTapped() {
        delegate?.didTapContinue()
    }
    
}
