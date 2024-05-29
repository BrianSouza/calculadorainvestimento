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
    @IBOutlet weak var pageControl: CustomPageControl!
    
    var CamposValidados: Bool = false
    
    private var _cdiService: CDIProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _cdiService = CDIService()
        processRing.isHidden = false
        processRing.startAnimating()
        SetLayout()
        let resultSearchApiCDI = _cdiService.GetCDIFromAPI()
        cdiText.setTextFieldText(String(resultSearchApiCDI))
        processRing.stopAnimating()
        processRing.isHidden = true
        
        pageControl.numberOfPages = 2
                pageControl.currentPage = 0
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
        ValidarCampos()
        if CamposValidados{
        simulacaoCalculada = try? calcularRendimentoBruto()
        }
    }
    func ValidarCampos(){
        CamposValidados = true
        if let txtInvestimento = Double(ctInvestimento.getTextFieldText() ?? "0"){
            if txtInvestimento == 0{
                ctInvestimento.setLabelTextError("Informe um número maior do que zero")
                CamposValidados = false
                return
            }
        }
        else{
            ctInvestimento.setLabelTextError("")
        }
        if let txtCDI = Double(cdiText.getTextFieldText() ?? "0"){
            if txtCDI == 0{
                cdiText.setLabelTextError("Informe um número maior do que zero")
                CamposValidados = false
                return
            }
        }
        else{
            cdiText.setLabelTextError("")
        }
        if let txtCBD = Double(cbdText.getTextFieldText() ?? "0"){
            if txtCBD == 0{
                cbdText.setLabelTextError("Informe um número maior do que zero")
                CamposValidados = false
                return
            }
        }
        else{
            cbdText.setLabelTextError("")
        }
        
        CamposValidados = true
        
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
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "segueMostraCalculo"{
            return CamposValidados
        }
        return true;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMostraCalculo"
        {
            if let mostraCalculoController = segue.destination as? ResultadoController{
                
                if  simulacaoCalculada != nil, CamposValidados{
                    mostraCalculoController.simulacaoParaExibir = simulacaoCalculada
                }
            }
        }
    }
}
