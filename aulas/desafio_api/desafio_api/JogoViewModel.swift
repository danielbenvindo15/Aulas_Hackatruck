import Foundation
import Combine

class JogoViewModel: ObservableObject {
    
    @Published var jogos: [Jogo] = []
    @Published var erro: String = ""
    
    func buscarJogos() {
        
        guard let url = URL(string: "http://localhost:1880/pegajogo") else {
            erro = "URL inválida"
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    self.erro = error.localizedDescription
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.erro = "Não foi possível receber os dados."
                }
                return
            }
            
            do {
                let jogosRecebidos = try JSONDecoder().decode(
                    [Jogo].self,
                    from: data
                )
                
                DispatchQueue.main.async {
                    self.jogos = jogosRecebidos
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.erro = "Erro ao ler o JSON: \(error)"
                }
            }
            
        }.resume()
    }
}
