//
//  CustomTextView.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 07/03/24.
//

import UIKit

class CustomTextView: UIView {
    let lblTitle = UILabel()
    let tfMain = UITextField()
    let lblError = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        // Adiciona a titulo
        addSubview(lblTitle)
        
        // Adiciona o textField principal
        addSubview(tfMain)
        
        // adicionar o lbl de erro
        addSubview(lblError)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Define os tamanhos e posições da lblTitle
        lblTitle.frame = CGRect(x: 10, y: 10, width: bounds.width - 20, height: 15)
        lblTitle.font = UIFont.systemFont(ofSize: 10)
        
        // Define os tamanhos e posições da tfMain
        tfMain.frame = CGRect(x: 10, y: lblTitle.frame.maxY + 10, width: bounds.width - 20, height: 30)
        tfMain.borderStyle = .none
        
        // Customiza o lblError
        lblError.frame = CGRect(x:10, y:tfMain.frame.maxY + 10, width: bounds.width - 20 , height: 15)
        lblError.textColor = UIColor.red
        lblError.font = UIFont.systemFont(ofSize: 8)
        
        //Add uma linha no tfMain
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: tfMain.frame.height - 1, width: tfMain.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor // Cor da linha
        tfMain.layer.addSublayer(bottomLine)
        
        // Define bordas arredondadas para o controle
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.frame.size.height = 100
        layer.frame
    }
    
    func setLabelText(_ text:String) {
        lblTitle.text = text
    }
    func getLabelText() -> String{
        if let text = lblTitle.text{
            return text
        }
        else{
            return ""
        }
    }
    func setTextFieldText(_ text:String){
        tfMain.text = text
    }
    func getTextFieldText() -> String{
        if let text = tfMain.text{
            return text
        }
        else{
            return ""
        }
    }
    func getLabelTextError() -> String{
        if let text = lblError.text{
            return text
        }
        else{
            return ""
        }
    }
    func setLabelTextError(_ text:String){
        lblError.text = text
    }
}

