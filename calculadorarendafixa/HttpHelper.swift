//
//  HttpHelper.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 06/02/24.
//

import Foundation
class HtttpHelper
{
    func fetchDataFromAPI(completion: @escaping (Result<ResponseData, Error>) -> Void) {
        // Defina a URL da API que deseja acessar
        let apiUrl = URL(string: "https://api.hgbrasil.com/finance/taxes?key=319ef0b3")!

        // Crie uma sessão URLSession
        let session = URLSession.shared

        // Crie uma tarefa de dados (data task) para fazer a solicitação HTTP
        let task = session.dataTask(with: apiUrl) { data, response, error in
            // Verifique se ocorreu algum erro
            if let error = error {
                completion(.failure(error))
                return
            }

            // Verifique se a resposta contém dados válidos
            guard let responseData = data else {
                let emptyResponseError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Resposta vazia"])
                completion(.failure(emptyResponseError))
                return
            }

            // Tente decodificar os dados recebidos em sua estrutura de dados desejada
            do {
                let decodedData = try JSONDecoder().decode(ResponseData.self, from: responseData)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        
        // Inicie a tarefa
        task.resume()
    }

}

