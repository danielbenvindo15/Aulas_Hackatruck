import Foundation
import Combine

//Importa as informacoes obtidas pela api 
class PersonagemViewModel: ObservableObject {
    
    @Published var personagens: [Personagem] = []
    
    func buscarPersonagens() {
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            print("URL inválida")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Erro na requisição: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Nenhum dado recebido")
                return
            }
            
            do {
                let resposta = try JSONDecoder().decode(
                    RespostaAPI.self,
                    from: data
                )
                
                DispatchQueue.main.async {
                    self.personagens = resposta.results
                }
                
            } catch {
                print("Erro ao converter JSON: \(error)")
            }
            
        }.resume()
    }
}
