
import SwiftUI
import FirebaseAI

// MARK: - Estrutura de uma mensagem

struct Mensagem: Identifiable {
    let id = UUID()
    let texto: String
    let enviadaPeloUsuario: Bool
}


// MARK: - Tela principal

struct ContentView: View {
    
    // Modelo do Gemini
    let model = FirebaseAI.firebaseAI(
        backend: .googleAI()
    ).generativeModel(
        modelName: "gemini-3.1-flash-lite"
    )
    
    // Texto digitado pelo usuário
    @State private var prompt: String = ""
    
    // Lista de mensagens da conversa
    @State private var mensagens: [Mensagem] = [
        Mensagem(
            texto: "Olá! 👨‍🍳 Sou seu assistente de receitas. Posso ajudar com receitas, ingredientes, substituições e dicas de preparo!",
            enviadaPeloUsuario: false
        )
    ]
    
    // Controla o carregamento
    @State private var isLoading: Bool = false
    
    
    // MARK: - Função para enviar mensagem
    
    func sendMessage() {
        
        // Impede o envio de mensagens vazias
        guard !prompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        let pergunta = prompt
        
        // Adiciona a mensagem do usuário na conversa
        mensagens.append(
            Mensagem(
                texto: pergunta,
                enviadaPeloUsuario: true
            )
        )
        
        // Limpa o campo
        prompt = ""
        
        // Mostra o carregamento
        isLoading = true
        
        
        // MARK: - Prompt de controle
        
        let instrucao = """
        Você é um chatbot especializado EXCLUSIVAMENTE em receitas e culinária.

        Você pode ajudar com:
        - Receitas
        - Ingredientes
        - Modo de preparo
        - Tempo de preparo
        - Dicas culinárias
        - Substituição de ingredientes
        - Quantidades e porções
        - Técnicas básicas de cozinha

        IMPORTANTE:
        Você NÃO deve responder perguntas que não tenham relação com culinária ou receitas.

        Se o usuário perguntar algo fora desse assunto, responda:
        "Desculpe! Eu sou um chatbot especializado em receitas e culinária. 🍳 Posso ajudar você com receitas, ingredientes ou dicas de preparo."

        Responda de maneira simples, amigável e objetiva.

        Pergunta do usuário:
        \(pergunta)
        """
        
        
        // MARK: - Comunicação com Gemini
        
        Task {
            do {
                
                let response = try await model.generateContent(instrucao)
                
                let resposta = response.text ?? "Não consegui encontrar uma resposta."
                
                // Adiciona resposta da IA
                mensagens.append(
                    Mensagem(
                        texto: resposta,
                        enviadaPeloUsuario: false
                    )
                )
                
            } catch {
                
                // Mostra erro caso a comunicação falhe
                mensagens.append(
                    Mensagem(
                        texto: "Ocorreu um erro ao conversar com o chatbot. 😕",
                        enviadaPeloUsuario: false
                    )
                )
            }
            
            // Finaliza carregamento
            isLoading = false
        }
    }
    
    
    // MARK: - Interface
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // MARK: Cabeçalho
            
            HStack {
                
                Image(systemName: "fork.knife")
                    .font(.title2)
                
                Text("ChefBot")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
            }
            .padding()
            .background(.thinMaterial)
            
            
            // MARK: Área das mensagens
            
            ScrollViewReader { proxy in
                
                ScrollView {
                    
                    VStack(spacing: 12) {
                        
                        ForEach(mensagens) { mensagem in
                            
                            HStack {
                                
                                if mensagem.enviadaPeloUsuario {
                                    Spacer()
                                }
                                
                                Text(mensagem.texto)
                                    .padding()
                                    .background(
                                        mensagem.enviadaPeloUsuario
                                        ? Color.blue.opacity(0.2)
                                        : Color.gray.opacity(0.15)
                                    )
                                    .cornerRadius(15)
                                
                                if !mensagem.enviadaPeloUsuario {
                                    Spacer()
                                }
                            }
                            .id(mensagem.id)
                        }
                        
                        
                        // Indicador de carregamento
                        
                        if isLoading {
                            
                            HStack {
                                
                                ProgressView()
                                
                                Text("Preparando uma resposta...")
                                    .foregroundStyle(.secondary)
                                
                                Spacer()
                            }
                        }
                    }
                    .padding()
                }
                
                // Faz a tela rolar para a última mensagem
                .onChange(of: mensagens.count) {
                    
                    if let ultimaMensagem = mensagens.last {
                        
                        withAnimation {
                            proxy.scrollTo(
                                ultimaMensagem.id,
                                anchor: .bottom
                            )
                        }
                    }
                }
            }
            
            
            // MARK: Campo de mensagem
            
            HStack(spacing: 10) {
                
                TextField(
                    "Digite sua dúvida sobre receitas...",
                    text: $prompt
                )
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    sendMessage()
                }
                
                
                Button {
                    sendMessage()
                } label: {
                    
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 30))
                }
                .disabled(
                    prompt
                        .trimmingCharacters(
                            in: .whitespacesAndNewlines
                        )
                        .isEmpty
                    || isLoading
                )
            }
            .padding()
            .background(.thinMaterial)
        }
    }
}


// MARK: - Preview

#Preview {
    ContentView()
}

