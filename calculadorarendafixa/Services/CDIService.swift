//
//  CDIService.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 19/05/24.
//

import Foundation
class CDIService : CDIProtocol{
    func GetCDIFromAPI() -> Double {
        let httpHelper = HtttpHelper()
        var retorno:Double = 0.00
        httpHelper.fetchDataFromAPI { [self] result in
            switch result {
            case .success(let responseData):
                DispatchQueue.main.async { [self] in
                    retorno = responseData.results[0].cdi
                }
            case .failure(let error):
                retorno = 0.00
            }
        }
        return retorno
    }
}
