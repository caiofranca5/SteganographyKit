//
//  TemplateView.swift
//  Example
//
//  Created by Caio França on 19/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import UIKit

protocol TemplateViewDelegate: AnyObject {
    func didTapContinue()
}

class TemplateView: UIView {
    
    weak var delegate: TemplateViewDelegate?
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var welcomeTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var welcomeSubtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        var filled = UIButton.Configuration.filled()
        filled.cornerStyle = .large
        filled.baseBackgroundColor = .systemRed
        
        var attText = AttributedString.init("")
        attText.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        filled.attributedTitle = attText
        
        let button = UIButton(configuration: filled, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(continueButtonTapped), for: .touchUpInside)
        button.isEnabled = true
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
        addSubview(imageView)
        addSubview(welcomeTitleLabel)
        addSubview(welcomeSubtitleLabel)
        addSubview(continueButton)
    }
    
    private func addConstraints() {
        let margins = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 32),
            imageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -32),
            imageView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.4)
            
        ])
        
        NSLayoutConstraint.activate([
            welcomeSubtitleLabel.topAnchor.constraint(equalTo: welcomeTitleLabel.bottomAnchor, constant: 16),
            welcomeSubtitleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16),
            welcomeSubtitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            welcomeTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 64),
            welcomeTitleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16),
            welcomeTitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16),
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

extension TemplateView {
    
    @objc func continueButtonTapped() {
        delegate?.didTapContinue()
    }
    
}

//MARK: - View Actions

extension TemplateView {
    
    func updateViewWith(newImage: String, newTitle: String, newSubtitle: String, newButtonTitle: String) {
        var attText = AttributedString.init(newButtonTitle)
        attText.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        
        imageView.image = UIImage(named: newImage)
        welcomeTitleLabel.text = newTitle
        welcomeSubtitleLabel.text = newSubtitle
        continueButton.configuration?.attributedTitle = attText
    }
    
}
