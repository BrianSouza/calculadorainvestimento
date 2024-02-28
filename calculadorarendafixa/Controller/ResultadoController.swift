//
//  ResultadoController.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 30/01/24.
//

import UIKit


class ResultadoController: UIViewController {

    var simulacaoParaExibir: SimulacaoInvestimento!
    
    @IBOutlet weak var txtValorBruto: UILabel!
    @IBOutlet weak var txtValorInicial: UILabel!
    @IBAction func reiniciarCalculo(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        txtValorBruto.text = "R$ \(simulacaoParaExibir.ValorRendimentoBruto)"
        
        txtValorInicial.text = "R$ \(simulacaoParaExibir.ValorInvestido)"
    }


}
