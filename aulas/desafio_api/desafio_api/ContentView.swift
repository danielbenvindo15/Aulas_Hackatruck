import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = JogoViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                if !viewModel.erro.isEmpty {
                    
                    Text(viewModel.erro)
                        .foregroundStyle(.red)
                        .padding()
                    
                } else {
                    
                    List(viewModel.jogos) { jogo in
                        
                        VStack(alignment: .leading) {
                            
                            Text(jogo.nome)
                                .font(.title3)
                                .bold()
                            
                            Text("Ano: \(jogo.ano)")
                                .foregroundStyle(.gray)
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .navigationTitle("Jogos")
            .onAppear {
                viewModel.buscarJogos()
            }
        }
    }
}

#Preview {
    ContentView()
}
