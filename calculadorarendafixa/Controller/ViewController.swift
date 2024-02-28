//
//  ViewController.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 23/01/24.
//

import UIKit

class ViewController: UIViewController {

   
    @IBAction func prepareForUnwind(segue: UIStoryboard)
    {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

