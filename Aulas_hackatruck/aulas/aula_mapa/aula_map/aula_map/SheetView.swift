import SwiftUI
import MapKit

struct SheetView: View {
    
    let local: Location
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 15) {
                
                // MARK: Foto
                
                AsyncImage(url: URL(string: local.imagem)) { phase in
                    if let image = phase.image {
                        // Imagem carregada com sucesso
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 500)
                    } else if phase.error != nil {
                        // Erro ao carregar
                        Image(systemName: "photo.badge.exclamationmark")
                            .font(.largeTitle)
                    } else {
                        // Carregando (placeholder)
                        ProgressView()
                    }
                }
                
                
                // MARK: Nome
                
                Text(local.nome)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                
                // MARK: País
                
                Text(local.pais)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                
                
                // MARK: Descrição
                
                Text(local.descricao)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                
                Spacer()
            }
            .padding()
        }
    }
}


#Preview {
    
    SheetView(
        local: Location(
            nome: "Cristo Redentor",
            descricao: "Localizado no Rio de Janeiro, Brasil, o Cristo Redentor é uma das construções mais conhecidas do mundo.",
            imagem: "cristo",
            pais: "Brasil",
            regiao: "América",
            coordenada: CLLocationCoordinate2D(
                latitude: -22.9519,
                longitude: -43.2105
            )
        )
    )
}
