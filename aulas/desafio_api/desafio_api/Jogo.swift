import Foundation

struct Jogo: Codable, Identifiable {
    let id = UUID()
    let nome: String
    let ano: Int
}
