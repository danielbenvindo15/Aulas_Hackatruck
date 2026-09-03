import SwiftUI
import Translation


// MARK: - MODELO DO CARDÁPIO

struct Prato: Codable, Identifiable {
    
    let id: Int
    let nome: String
    let preco: Int
    let categoria: String
    let imagem: String
}


// MARK: - SERVIÇO DA API

class CardapioService {
    
    // Coloque aqui o endereço do seu Node-RED
    private let urlAPI = "http://127.0.0.1:1880/pegarcardapio"
    
    
    func buscarCardapio() async throws -> [Prato] {
        
        guard let url = URL(string: urlAPI) else {
            throw URLError(.badURL)
        }
        
        // Faz a requisição GET
        let (data, response) = try await URLSession.shared.data(
            from: url
        )
        
        // Verifica a resposta
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // Converte o JSON em objetos Prato
        let pratos = try JSONDecoder().decode(
            [Prato].self,
            from: data
        )
        
        return pratos
    }
}


// MARK: - TELA PRINCIPAL

struct ContentView: View {
    
    @State private var pratos: [Prato] = []
    
    @State private var carregando = true
    
    @State private var mensagemErro: String?
    
    
    // Categorias do cardápio
    let categorias = [
        "Entrada",
        "Principal",
        "Sobremesa",
        "Bebida"
    ]
    
    
    var body: some View {
        
        ScrollView {
            
            VStack(
                alignment: .leading,
                spacing: 0
            ) {
                
                // =========================================
                // CABEÇALHO
                // =========================================
                
                VStack {
                    
                    Text("HackaTruck GastroBar")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background(
                    Color(
                        red: 1.0,
                        green: 0.95,
                        blue: 0.55
                    )
                )
                
                
                // =========================================
                // CARREGANDO
                // =========================================
                
                if carregando {
                    
                    VStack(spacing: 15) {
                        
                        ProgressView()
                            .scaleEffect(1.3)
                        
                        Text("Carregando cardápio...")
                            .foregroundColor(.black)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(40)
                }
                
                
                // =========================================
                // ERRO
                // =========================================
                
                else if let mensagemErro = mensagemErro {
                    
                    VStack(spacing: 15) {
                        
                        Image(
                            systemName:
                                "exclamationmark.triangle"
                        )
                        .font(.largeTitle)
                        
                        Text(
                            "Não foi possível carregar o cardápio."
                        )
                        .font(.headline)
                        
                        Text(mensagemErro)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                        
                        Button("Tentar novamente") {
                            
                            Task {
                                await carregarCardapio()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(40)
                }
                
                
                // =========================================
                // CARDÁPIO
                // =========================================
                
                else {
                    
                    ForEach(
                        categorias,
                        id: \.self
                    ) { categoria in
                        
                        mostrarCategoria(categoria)
                    }
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        
        // Carrega os dados quando a tela aparece
        .task {
            await carregarCardapio()
        }
    }
    
    
    // MARK: - MOSTRAR CATEGORIA
    
    @ViewBuilder
    func mostrarCategoria(
        _ categoria: String
    ) -> some View {
        
        // Pega somente os pratos
        // daquela categoria
        
        let pratosDaCategoria = pratos.filter {
            $0.categoria == categoria
        }
        
        
        // Só mostra a categoria
        // se houver pratos
        
        if !pratosDaCategoria.isEmpty {
            
            VStack(
                alignment: .leading,
                spacing: 0
            ) {
                
                // =========================================
                // NOME DA CATEGORIA
                // =========================================
                
                Text(
                    categoria.uppercased()
                )
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.horizontal, 15)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .frame(height: 40)
                .background(
                    Color(
                        red: 1.0,
                        green: 0.95,
                        blue: 0.55
                    )
                )
                
                
                // =========================================
                // PRATOS
                // =========================================
                
                VStack(spacing: 0) {
                    
                    ForEach(
                        pratosDaCategoria
                    ) { prato in
                        
                        ItemCardapio(
                            prato: prato
                        )
                    }
                }
                .background(
                    Color(
                        red: 0.48,
                        green: 0.72,
                        blue: 0.92
                    )
                )
            }
        }
    }
    
    
    // MARK: - BUSCAR CARDÁPIO
    
    func carregarCardapio() async {
        
        carregando = true
        mensagemErro = nil
        
        do {
            
            let service = CardapioService()
            
            let resultado =
                try await service.buscarCardapio()
            
            await MainActor.run {
                
                pratos = resultado
                
                carregando = false
            }
            
        } catch {
            
            await MainActor.run {
                
                mensagemErro =
                    error.localizedDescription
                
                carregando = false
            }
        }
    }
}


// MARK: - ITEM DO CARDÁPIO

struct ItemCardapio: View {
    
    let prato: Prato
    
    // Controla a tradução nativa
    @State private var mostrarTraducao = false
    
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            
            // =============================================
            // IMAGEM PELA URL
            // =============================================
            
            AsyncImage(
                url: URL(string: prato.imagem)
            ) { fase in
                
                switch fase {
                    
                // Enquanto carrega
                case .empty:
                    
                    ProgressView()
                        .frame(
                            width: 80,
                            height: 80
                        )
                    
                    
                // Quando conseguiu carregar
                case .success(let imagem):
                    
                    imagem
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: 80,
                            height: 80
                        )
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 10
                            )
                        )
                    
                    
                // Caso dê erro
                case .failure:
                    
                    Image(
                        systemName: "photo"
                    )
                    .font(.title)
                    .foregroundColor(.gray)
                    .frame(
                        width: 80,
                        height: 80
                    )
                    .background(
                        Color.gray.opacity(0.2)
                    )
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 10
                        )
                    )
                    
                    
                @unknown default:
                    
                    EmptyView()
                }
            }
            
            
            // =============================================
            // NOME E PREÇO
            // =============================================
            
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                
                Text(prato.nome)
                    .font(
                        .system(size: 14)
                    )
                    .foregroundColor(.black)
                    .lineLimit(2)
                
                
                Text(
                    "R$ \(prato.preco)"
                )
                .font(
                    .system(size: 14)
                )
                .foregroundColor(.black)
            }
            
            
            Spacer()
            
            
            // =============================================
            // BOTÃO DE TRADUÇÃO
            // =============================================
            
            Button {
                
                mostrarTraducao = true
                
            } label: {
                
                Image(
                    systemName: "translate"
                )
                .font(
                    .system(size: 18)
                )
                .foregroundColor(.black)
            }
            .buttonStyle(.plain)
        }
        .padding(
            .horizontal,
            15
        )
        .padding(
            .vertical,
            7
        )
        
        
        // =============================================
        // TRADUÇÃO NATIVA DO IOS
        // =============================================
        
        .translationPresentation(
            isPresented: $mostrarTraducao,
            text: prato.nome
        )
    }
}


// MARK: - PREVIEW

#Preview {
    ContentView()
}
