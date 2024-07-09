//
//  CustomTextView.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 07/03/24.
//
import UIKit

class CustomTextView: UIView, UITextFieldDelegate {
    let lblTitle = UILabel()
    let tfMain = UITextField()
    let lblError = UILabel()
    var isDecimal: Bool = false

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        setupUI()
        setupTextField()
        addDoneButtonOnKeyboard()
    }

    private func setupUI() {
        addSubview(lblTitle)
        addSubview(tfMain)
        addSubview(lblError)
    }
    
    private func setupTextField() {
        tfMain.text = "0.00"
        tfMain.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfMain.delegate = self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutLabelsAndTextField()
        setBorderControl(false)
    }

    private func layoutLabelsAndTextField() {
        
        // Configurar fonte, tamanho e peso
                let baseTitleSize: CGFloat = 17.0
                let systemBoldFont = UIFont.systemFont(ofSize: baseTitleSize, weight: .bold)
                
                // Configurar Dynamic Type para a fonte
                let fonteTitle = UIFontMetrics(forTextStyle: .body).scaledFont(for: systemBoldFont)
                
                // Ajustar fonte para o Content Size Category
        lblTitle.adjustsFontForContentSizeCategory = true
        
        lblTitle.frame = CGRect(x: 10, y: 10, width: bounds.width - 20, height: 15)
        lblTitle.font = UIFont.systemFont(ofSize: 10)
        
        tfMain.frame = CGRect(x: 10, y: lblTitle.frame.maxY + 10, width: bounds.width - 20, height: 30)
        tfMain.borderStyle = .roundedRect
        tfMain.font = UIFont.systemFont(ofSize: 10)
        
        lblError.frame = CGRect(x: 10, y: tfMain.frame.maxY + 10, width: bounds.width - 20, height: 15)
        lblError.textColor = .red
        lblError.font = UIFont.systemFont(ofSize: 8)
    }

    // MARK: - Customization Methods
    func setKeyboardType(_ type: UIKeyboardType) {
        tfMain.keyboardType = type
    }
    
    func setBorderControl(_ enable: Bool) {
        if enable {
            layer.cornerRadius = 10
            layer.borderWidth = 1
            layer.borderColor = UIColor.lightGray.cgColor
        } else {
            layer.borderWidth = 0
        }
    }

    func setLabelText(_ text: String) {
        lblTitle.text = text
    }
    
    func getLabelText() -> String {
        return lblTitle.text ?? ""
    }
    
    func setTextFieldPlaceholder(_ text: String) {
        tfMain.placeholder = text
    }
    
    func enableTextField(_ isEnabled: Bool) {
        tfMain.isEnabled = isEnabled
    }
    
    func setTextFieldText(_ text: String) {
        tfMain.text = text
    }
    
    func getTextFieldText() -> String {
        return tfMain.text ?? ""
    }
    
    func setLabelTextError(_ text: String) {
        lblError.text = text
    }
    
    func getLabelTextError() -> String {
        return lblError.text ?? ""
    }

    // MARK: - TextField Change Handling
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard var text = textField.text, !text.isEmpty else {
            textField.text = "0.00"
            return
        }

        text = text.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        text = text.replacingOccurrences(of: "\\.", with: "", options: .regularExpression)
        
        let decimalValue = Double(text) ?? 0.0
        let formattedText = String(format: "%.2f", decimalValue / 100)
        textField.text = formattedText
    }

    // MARK: - Done Button on Keyboard
    private func addDoneButtonOnKeyboard() {
        let doneToolbar = UIToolbar()
        doneToolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        doneToolbar.items = [flexSpace, doneButton]
        doneToolbar.barStyle = .default
        
        tfMain.inputAccessoryView = doneToolbar
    }
    
    @objc private func doneButtonAction() {
        tfMain.resignFirstResponder()
    }
}


