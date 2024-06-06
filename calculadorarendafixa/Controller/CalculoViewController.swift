//
//  CalculoViewController.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 06/02/24.
//
import UIKit

class CalculoViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var cdiText: CustomTextView!
    @IBOutlet weak var ctInvestimento: CustomTextView!
    @IBOutlet weak var cbdText: CustomTextView!
    @IBOutlet weak var processRing: UIActivityIndicatorView!
    @IBOutlet weak var pageControl: CustomPageControl!

    // MARK: - Properties
    var simulacaoCalculada: SimulacaoInvestimento?
    private var _cdiService: CDIProtocol!
    var camposValidados: Bool = false

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        _cdiService = CDIService()
        configureView()
        fetchData()
        setupKeyboardNotifications()
        setupTextFieldDelegates()
    }

    deinit {
        removeKeyboardNotifications()
    }

    // MARK: - Configuration Methods
    private func configureView() {
        processRing.isHidden = false
        processRing.startAnimating()
        setupLayout()
        processRing.stopAnimating()
        processRing.isHidden = true

        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
    }

    private func setupLayout() {
        ctInvestimento.setLabelText("Valor Investimento")
        ctInvestimento.setKeyboardType(.decimalPad)

        cdiText.setLabelText("Valor % CDI")
        cdiText.setKeyboardType(.decimalPad)

        cbdText.setLabelText("Valor % CDB")
        cbdText.setKeyboardType(.decimalPad)
    }

    private func setupTextFieldDelegates() {
        cdiText.tfMain.delegate = self
        ctInvestimento.tfMain.delegate = self
        cbdText.tfMain.delegate = self
    }

    // MARK: - Data Fetching
    private func fetchData() {
        Task {
            do {
                let results = try await _cdiService.fetchFinanceData()
                await MainActor.run {
                    if let cdiConsultado = results.first {
                        cdiText.setTextFieldText(String(cdiConsultado.cdiDaily))
                    } else {
                        cdiText.setTextFieldText("0.00")
                    }
                }
            } catch {
                print("Erro ao buscar dados: \(error)")
            }
        }
    }

    // MARK: - Keyboard Handling
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(_ notification: NSNotification) {
        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            adjustViewForKeyboard(show: true, keyboardHeight: keyboardFrame.height)
        }
    }

    @objc private func keyboardWillHide(_ notification: NSNotification) {
        adjustViewForKeyboard(show: false, keyboardHeight: 0)
    }

    private func adjustViewForKeyboard(show: Bool, keyboardHeight: CGFloat) {
        let adjustmentHeight = show ? keyboardHeight : 0
        var aRect = view.frame
        aRect.size.height -= adjustmentHeight

        if let activeTextField = view.firstResponder as? UITextField {
            let textFieldFrame = activeTextField.convert(activeTextField.bounds, to: view)
            if show && !aRect.contains(textFieldFrame.origin) {
                view.frame.origin.y = -keyboardHeight
            } else {
                view.frame.origin.y = 0
            }
        } else {
            view.frame.origin.y = 0
        }
    }

    // MARK: - Actions
    @IBAction func calcularENavegar(_ sender: Any) {
        validarCampos()
        if camposValidados {
            simulacaoCalculada = try? calcularRendimentoBruto()
        }
    }

    // MARK: - Validation Methods
    private func validarCampos() {
        camposValidados = true

        validateTextField(ctInvestimento, errorMessage: "Informe um número maior do que zero")
        validateTextField(cdiText, errorMessage: "Informe um número maior do que zero")
        validateTextField(cbdText, errorMessage: "Informe um número maior do que zero")
    }

    private func validateTextField(_ textView: CustomTextView, errorMessage: String) {
        if let textValue = Double(textView.getTextFieldText()), textValue == 0 {
            textView.setLabelTextError(errorMessage)
            camposValidados = false
        } else {
            textView.setLabelTextError("")
        }
    }

    // MARK: - Calculation Methods
    private func calcularRendimentoBruto() throws -> SimulacaoInvestimento {
        guard let valorInvestimento = Double(ctInvestimento.getTextFieldText()),
              let porcentagemCdi = Double(cdiText.getTextFieldText()),
              let porcentagemCDB = Double(cbdText.getTextFieldText()) else {
            throw Erros.erroDeCalculo
        }

        let valorBrutoRendimento = (((porcentagemCDB / 100) * (porcentagemCdi / 100)) * valorInvestimento) + valorInvestimento
        return SimulacaoInvestimento(ValorInvestido: valorInvestimento, PercCdi: porcentagemCdi, PercCdb: porcentagemCDB, ValorRendimentoBruto: valorBrutoRendimento)
    }

    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "segueMostraCalculo" {
            return camposValidados
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMostraCalculo",
           let mostraCalculoController = segue.destination as? ResultadoController,
           camposValidados, let simulacao = simulacaoCalculada {
            mostraCalculoController.simulacaoParaExibir = simulacao
        }
    }
}

// MARK: - Extensions
extension UIView {
    var firstResponder: UIResponder? {
        guard !isFirstResponder else { return self }
        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }
        return nil
    }
}

extension CalculoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let userInfo = UIResponder.keyboardFrameEndUserInfoKey as? [AnyHashable: Any],
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            adjustViewForKeyboard(show: true, keyboardHeight: keyboardFrame.height)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        adjustViewForKeyboard(show: false, keyboardHeight: 0)
    }
}
