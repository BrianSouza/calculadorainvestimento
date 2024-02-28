//
//  ResponseData.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 06/02/24.
//

struct ResponseData: Codable {
   
    let by: String
    let valid_key: Bool
    let results: [Results]
    let execution_time: Double
    let from_cache: Bool
}

