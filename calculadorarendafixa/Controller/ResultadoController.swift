//
//  ResultadoController.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 30/01/24.
//

import UIKit


class ResultadoController: UIViewController {

    var simulacaoParaExibir: SimulacaoInvestimento!
    @IBOutlet weak var tornPaperCardView: TornPaperCardView!
    @IBOutlet weak var pageControl: CustomPageControl!
    @IBOutlet weak var txtValorBruto: UILabel!
    @IBOutlet weak var txtPercCDB: UILabel!
    @IBOutlet weak var txtPercDCI: UILabel!
    @IBOutlet weak var txtValorInvestido: UILabel!
    @IBAction func reiniciarCalculo(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCardContent()
        configureView()
        
        let valorInvestido = String(format: "%.2f", simulacaoParaExibir.ValorInvestido)
        txtValorInvestido.text = "R$ \(valorInvestido)"
        
        let percCdi = String(format: "%.2f", simulacaoParaExibir.PercCdi)
        txtPercDCI.text = " \(percCdi)%"
        
        let percCdb = String(format: "%.2f", simulacaoParaExibir.PercCdb)
        txtPercCDB.text = " \(percCdb)%"
        
        let valorBruto = String(format: "%.2f", simulacaoParaExibir.ValorRendimentoBruto)
        txtValorBruto.text = "R$ \(valorBruto)"
    }
    // MARK: - Configuration Methods
    private func configureView() {
        
        pageControl.numberOfPages = 2
        pageControl.currentPage = 1
    }
    private func setupCardContent() {
           
        }

}
