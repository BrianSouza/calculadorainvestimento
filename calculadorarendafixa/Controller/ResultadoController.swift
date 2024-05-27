//
//  ResultadoController.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 30/01/24.
//

import UIKit


class ResultadoController: UIViewController {

    var simulacaoParaExibir: SimulacaoInvestimento!
    
    @IBOutlet weak var txtValorBruto: CustomTextView!
    @IBOutlet weak var txtPercCDB: CustomTextView!
    @IBOutlet weak var txtPercDCI: CustomTextView!
    @IBOutlet weak var txtValorInvestido: CustomTextView!
    @IBAction func reiniciarCalculo(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        txtValorInvestido.setLabelText("Seu aporte inicial da simulação foi de:")
        txtValorInvestido.setTextFieldText("R$ \(simulacaoParaExibir.ValorInvestido)")
        txtValorInvestido.EnableTextFieldText(false)
        
        txtPercDCI.setLabelText("Com a taxa de CDI de:")
        txtPercDCI.setTextFieldText(" \(simulacaoParaExibir.PercCdi)%")
        txtPercDCI.EnableTextFieldText(false)
        
        txtPercCDB.setLabelText("e porcentagem de CDB de:")
        txtPercCDB.setTextFieldText(" \(simulacaoParaExibir.PercCdb)%")
        txtPercCDB.EnableTextFieldText(false)
        
        txtValorBruto.setLabelText("Seu rendimento BRUTO será de:")
        txtValorBruto.setTextFieldText("R$ \(simulacaoParaExibir.ValorRendimentoBruto)")
        txtValorBruto.EnableTextFieldText(false)
    }


}
