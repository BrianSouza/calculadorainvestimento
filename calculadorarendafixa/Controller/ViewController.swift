//
//  ViewController.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 23/01/24.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var r: UILabel!
    @IBOutlet weak var lbCalcule: UILabel!
    @IBAction func prepareForUnwind(segue: UIStoryboard)
    {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFont()
    }

func setFont()
    {
        // Configurar Dynamic Type
        r.font = UIFont.preferredFont(forTextStyle: .title1)
        r.adjustsFontForContentSizeCategory = true
                
        lbCalcule.font = UIFont.preferredFont(forTextStyle: .body)
        lbCalcule.adjustsFontForContentSizeCategory = true
    }
}

