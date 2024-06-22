//
//  CircleView.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 16/06/24.
//

import UIKit

class CircleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.backgroundColor = .blue
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        
        // Add checkmark image
        let checkmarkImageView = UIImageView(image: UIImage(systemName: "checkmark"))
        checkmarkImageView.tintColor = .white
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(checkmarkImageView)
        
        // Center the checkmark image within the circle
        NSLayoutConstraint.activate([
            checkmarkImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            checkmarkImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
