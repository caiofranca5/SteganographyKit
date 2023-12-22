//
//  LoadingView.swift
//  Example
//
//  Created by Caio França on 22/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
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
        addSubview(spinner)
    }
    
    private func addConstraints() {
        let margins = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: margins.centerYAnchor)
        ])
    }
}
