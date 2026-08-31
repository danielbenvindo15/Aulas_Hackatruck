//
//  APIService.swift
//  desafio_api
//
//  Created by Turma01-2 on 31/08/26.
//

import Foundation

class APIService {
    
    // Coloque aqui o endereço da sua API
    private let url = "http://192.168.1.10:1880/jogos"
    
    func buscarJogos() async throws -> [Jogo] {
        
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(
            from: url
        )
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let jogos = try JSONDecoder().decode(
            [Jogo].self,
            from: data
        )
        
        return jogos
    }
}
