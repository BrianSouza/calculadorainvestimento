//
//  Results.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 06/02/24.
//

import Foundation

struct Results: Codable {
    let date: String
    let cdi: Double
    let selic: Double
    let dailyFactor: Double
    let selicDaily: Double
    let cdiDaily: Double
    
    // Mapeando os nomes das propriedades JSON para as propriedades do struct
    enum CodingKeys: String, CodingKey {
        case date
        case cdi
        case selic
        case dailyFactor = "daily_factor"
        case selicDaily = "selic_daily"
        case cdiDaily = "cdi_daily"
    }
}

// Estrutura adicional para corresponder ao formato da resposta da API
struct APIResponse: Codable {
    let results: [Results]
}


