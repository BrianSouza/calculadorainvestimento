//
//  CDIService.swift
//  calculadorarendafixa
//
//  Created by Brian Diego De Souza on 19/05/24.
//

import Foundation
class CDIService : CDIProtocol{
    // Função assíncrona para buscar dados da API e decodificar para o struct Results
    func fetchFinanceData() async throws -> [Results] {
        let urlString = "https://api.hgbrasil.com/finance/taxes?key=319ef0b3"
        
        // Verifica se a URL é válida
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // Realiza a chamada de rede de forma assíncrona
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Verifica se a resposta HTTP é válida
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // Decodifica os dados JSON para o struct APIResponse
        let decoder = JSONDecoder()
        let responseData = try decoder.decode(APIResponse.self, from: data)
        
        // Retorna os resultados decodificados
        return responseData.results
    }

   /* func GetCDIFromAPI() -> Double {
        let httpHelper = HtttpHelper()
        var retorno:Double = 0.00
        
        Task {
                    do {
                        let todo = try await fetchTodoData(from: url)
                        
                        // Garantir que a atualização da UI seja feita na main thread
                        await MainActor.run {
                            print("Dados do Todo: \(todo)")
                            // Atualizar a UI aqui
                        }
                        
                    } catch {
                        print("Erro ao buscar dados: \(error)")
                    }
                }
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
    }*/
}
