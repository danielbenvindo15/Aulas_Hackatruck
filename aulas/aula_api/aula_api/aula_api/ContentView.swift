import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = PersonagemViewModel()
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            // MARK: - Banner
            
            Image("pixelframe-design")
                .resizable()
                .scaledToFit()
                .frame(height: 220)
                .clipped()
            
            
            // MARK: - Lista
            
            
            List(viewModel.personagens) { personagem in
                
                HStack(spacing: 15) {
                    
                    AsyncImage(
                        url: URL(string: personagem.image)
                    ) { imagem in
                        
                        imagem
                            .resizable()
                            .scaledToFill()
                        
                    } placeholder: {
                        
                        ProgressView()
                    }
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text(personagem.name)
                            .font(.headline)
                        
                        Text(personagem.species)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text("Status: \(personagem.status)")
                            .font(.caption)
                    }
                }
                .padding(.vertical, 5)
            }
            .padding(.top, 220)
            .listStyle(.plain)
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            viewModel.buscarPersonagens()
        }
        
        
    }
}

#Preview {
    ContentView()
}
