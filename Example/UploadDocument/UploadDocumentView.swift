//
//  UploadDocumentView.swift
//  Example
//
//  Created by Caio França on 21/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import UIKit

protocol UploadDocumentViewDelegate: AnyObject {
    func didTapUpload()
    func didTapContinue()
}

class UploadDocumentView: UIView {
    
    weak var delegate: UploadDocumentViewDelegate?
    
    private lazy var uploadDocumentTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        label.text = "National ID"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var uploadDocumentSubtitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        label.text = "Upload a photo or scan of your document."
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var uploadButton: UIButton = {
        var borderless = UIButton.Configuration.borderless()
        borderless.image = UIImage(systemName: "arrow.up.doc")
        borderless.imagePlacement = .leading
        borderless.imagePadding = 10
        
        var attText = AttributedString.init("Upload")
        attText.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        borderless.attributedTitle = attText
        
        let button = UIButton(configuration: borderless, primaryAction: nil)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(uploadButtonTapped), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
    lazy var continueButton: UIButton = {
        var filled = UIButton.Configuration.filled()
        filled.cornerStyle = .large
        filled.baseBackgroundColor = .systemRed
        
        var attText = AttributedString.init("Done")
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
        addSubview(imageView)
        addSubview(uploadDocumentTitle)
        addSubview(uploadDocumentSubtitle)
        addSubview(uploadButton)
        addSubview(continueButton)
    }
    
    private func addConstraints() {
        let margins = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            uploadDocumentTitle.topAnchor.constraint(equalTo: margins.topAnchor, constant: 16),
            uploadDocumentTitle.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16),
            uploadDocumentTitle.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            uploadDocumentSubtitle.topAnchor.constraint(equalTo: uploadDocumentTitle.bottomAnchor, constant: 16),
            uploadDocumentSubtitle.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16),
            uploadDocumentSubtitle.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: uploadDocumentSubtitle.bottomAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            uploadButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            uploadButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16),
            uploadButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16)
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

extension UploadDocumentView {
    
    @objc func continueButtonTapped() {
        delegate?.didTapContinue()
    }
    
    @objc func uploadButtonTapped() {
        delegate?.didTapUpload()
    }
    
}
