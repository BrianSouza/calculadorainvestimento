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
    var isDecimal: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupDecimal()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        setupDecimal()
    }
    private func setupDecimal(){
        
        // Definindo o texto inicial como "0.00"
        tfMain.text = "0.00"
                
        // Adicionando um target para monitorar as mudanças de texto
        tfMain.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
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
        tfMain.endEditing(true)
        
        // Define bordas arredondadas para o controle
        setBorderControll(false)
    }
    func setKeyboardType(_ type:UIKeyboardType){
        tfMain.keyboardType = type
    }
    func setBorderControll(_ ligar:Bool){
        if(ligar){
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.frame.size.height = 100
        }
        else{
            layer.borderWidth = 0
        }
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
    func setTextFieldPlaceHolder(_ text:String){
        tfMain.placeholder = text
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
    @objc private func textFieldDidChange(_ textField: UITextField) {
        
            // Garantindo que o texto seja formatado corretamente
            
            guard var text = textField.text, !text.isEmpty else {
                // Se o texto estiver vazio, definimos como "0.00"
                textField.text = "0.00"
                return
            }
        // Removendo caracteres não numéricos e o ponto decimal, caso já exista
                text = text.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
                text = text.replacingOccurrences(of: "\\.", with: "", options: .regularExpression)
                
                // Formatando o texto adequadamente
                let decimalValue = Double(text) ?? 0.0
                let formattedText = String(format: "%.2f", decimalValue / 100)
                
                // Definindo o texto formatado no campo
                textField.text = formattedText
    }
}

