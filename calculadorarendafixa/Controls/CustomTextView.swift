//
//  CustomTextView.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 07/03/24.
//

import UIKit

class CustomTextView: UIView {
    let label = UILabel()
    let textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        // Adiciona a label
        label.text = "Label:"
        addSubview(label)
        
        // Adiciona o textField
        textField.borderStyle = .roundedRect
        addSubview(textField)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Define os tamanhos e posições dos elementos
        label.frame = CGRect(x: 10, y: 10, width: bounds.width - 20, height: 30)
        textField.frame = CGRect(x: 10, y: label.frame.maxY + 10, width: bounds.width - 20, height: 30)
        
        // Define bordas arredondadas para o controle
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
}

