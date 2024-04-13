//
//  CalculoViewController.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 06/02/24.
//

import UIKit


class CalculoViewController: UIViewController {
    
    var simulacaoCalculada: SimulacaoInvestimento?
    @IBOutlet weak var cdiText: CustomTextView!
    @IBOutlet weak var ctInvestimento: CustomTextView!
    @IBOutlet weak var cbdText: CustomTextView!
    @IBOutlet weak var processRing: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        processRing.isHidden = false
        processRing.startAnimating()
        SetLayout()
        // Do any additional setup after loading the view.
        let httpHelper = HtttpHelper()
        httpHelper.fetchDataFromAPI { [self] result in
            switch result {
            case .success(let responseData):
                DispatchQueue.main.async { [self] in
                    self.cdiText.setTextFieldText(String(responseData.results[0].cdi))
                    processRing.stopAnimating()
                    processRing.isHidden = true
                }
                
            case .failure(let error):
                // Trate o erro adequadamente
                print("Erro ao buscar dados da API: \(error)")
                processRing.stopAnimating()
                processRing.isHidden = true
            }
            
        }

    }
    func SetLayout(){
        ctInvestimento.setLabelText("Valor Investimento")
        ctInvestimento.setKeyboardType(.decimalPad)
        
        cdiText.setLabelText("Valor % CDI")
        cdiText.setKeyboardType(.decimalPad)
        
        cbdText.setLabelText("Valor % CDB")
        cbdText.setKeyboardType(.decimalPad)

    }
    
    @IBAction func calcularENavegar(_ sender: Any) {
        
        if ValidarCampos(){
        simulacaoCalculada = try? calcularRendimentoBruto()
        }
    }
    func ValidarCampos() -> Bool{
        if let txtInvestimento = Double(ctInvestimento.getTextFieldText() ?? "0"){
            if txtInvestimento == 0{
                ctInvestimento.setLabelText("Informe um número maior do que zero")
                return false
            }
        }
        if let txtCDI = Double(cdiText.getTextFieldText() ?? "0"){
            if txtCDI == 0{
                cdiText.setLabelText("Informe um número maior do que zero")
                return false
            }
        }
        if let txtCBD = Double(cdiText.getTextFieldText() ?? "0"){
            if txtCBD == 0{
                cbdText.setLabelText("Informe um número maior do que zero")
                return false
            }
        }
        return true
    }
    func calcularRendimentoBruto() throws -> SimulacaoInvestimento{
        
        if let valorInvestimento = Double(ctInvestimento.getTextFieldText() ?? "0") , let porcentagemCdi = Double(cdiText.getTextFieldText() ?? "0"), let porcentagemCDB = Double(cbdText.getTextFieldText() ?? "0"){
            
            let valorBrutoRendimento = (((porcentagemCDB / 100) * (porcentagemCdi / 100)) * valorInvestimento) + valorInvestimento
            
            let calculo = SimulacaoInvestimento(ValorInvestido: valorInvestimento, PercCdi: porcentagemCdi, PercCdb: porcentagemCDB, ValorRendimentoBruto: valorBrutoRendimento)
            
            return calculo
        }
        else{
            throw Erros.erroDeCalculo
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMostraCalculo"
        {
            if let mostraCalculoController = segue.destination as? ResultadoController{
                
                if  simulacaoCalculada != nil{
                    mostraCalculoController.simulacaoParaExibir = simulacaoCalculada
                }
                else{
                    segue.destination.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
