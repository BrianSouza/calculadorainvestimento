//
//  CalculoViewController.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 06/02/24.
//

import UIKit


class CalculoViewController: UIViewController {
    
    var simulacaoCalculada: SimulacaoInvestimento?
    @IBOutlet weak var cdiText: UITextField!
    @IBOutlet weak var valorInvestimentoText: UITextField!
    @IBOutlet weak var cbdText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let httpHelper = HtttpHelper()
        httpHelper.fetchDataFromAPI { result in
            switch result {
            case .success(let responseData):
                DispatchQueue.main.async {
                    self.cdiText.text = String(responseData.results[0].cdi)
                       }
                
            case .failure(let error):
                // Trate o erro adequadamente
                print("Erro ao buscar dados da API: \(error)")
            }
        
        }

    }
    
    @IBAction func calcularENavegar(_ sender: Any) {
        
            simulacaoCalculada = try? calcularRendimentoBruto()
        
    }
    func calcularRendimentoBruto() throws -> SimulacaoInvestimento{
        if let valorInvestimento = Double(valorInvestimentoText.text ?? "0") , let porcentagemCdi = Double(cdiText.text ?? "0"), let porcentagemCDB = Double(cbdText.text ?? "0"){
            
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
