//
//  CircularButton.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 05/03/24.
//

import UIKit

class CircularButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        // Define a forma circular para o botão
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
}
