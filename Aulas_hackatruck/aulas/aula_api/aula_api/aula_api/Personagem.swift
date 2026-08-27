//
//  Personagem.swift
//  aula_api
//
//  Created by Turma01-2 on 27/08/26.
//

import Foundation

// Cria uma variavel de um tipo personalizavel que vai conter todos os
// arquivos que precisam ser acessados do banco de dados
struct Personagem: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
}

struct RespostaAPI: Codable {
    let results: [Personagem]
}
