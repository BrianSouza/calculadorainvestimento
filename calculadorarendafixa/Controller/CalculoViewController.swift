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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetLayout()
        // Do any additional setup after loading the view.
        let httpHelper = HtttpHelper()
        httpHelper.fetchDataFromAPI { result in
            switch result {
            case .success(let responseData):
                DispatchQueue.main.async {
                    self.cdiText.setTextFieldText(String(responseData.results[0].cdi))
                       }
                
            case .failure(let error):
                // Trate o erro adequadamente
                print("Erro ao buscar dados da API: \(error)")
            }
        
        }

    }
    func SetLayout(){
        ctInvestimento.setLabelText("Valor Investimento")
        ctInvestimento.setTextFieldText("0")
        ctInvestimento.setLabelTextError("teste")
        ctInvestimento.setKeyboardType(.decimalPad)
        
        cdiText.setLabelText("Valor % CDI")
        cdiText.setTextFieldText("0")
        cdiText.setLabelTextError("teste")
        cdiText.setKeyboardType(.decimalPad)
        
        cbdText.setLabelText("Valor % CDB")
        cbdText.setTextFieldText("0")
        cbdText.setLabelTextError("teste")
        cbdText.setKeyboardType(.decimalPad)

    }
    
    @IBAction func calcularENavegar(_ sender: Any) {
        
            simulacaoCalculada = try? calcularRendimentoBruto()
        
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
