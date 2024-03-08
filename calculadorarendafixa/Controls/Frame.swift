//
//  Frame.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 07/03/24.
//

import UIKit

class Frame: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        // Define a forma circular para o botão
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.red.cgColor
        clipsToBounds = true
    }
}
