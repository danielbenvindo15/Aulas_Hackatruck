import SwiftUI

struct Midia {
    
    var idMidia: Int
    var nomeMidia: String
    var fotoMidia: String
    var categoriaMidia: String
    var generoMidia: String
    var paisMidia: String
}

struct ContentView: View {
    
    var conteudos: [Midia] = [
        
        Midia(
            idMidia: 1,
            nomeMidia: "O Senhor dos Anéis: A Sociedade do Anel",
            fotoMidia: "senhor_aneis",
            categoriaMidia: "Filme",
            generoMidia: "Fantasia/Aventura",
            paisMidia: "Nova Zelândia"
        ),
        
        Midia(
            idMidia: 2,
            nomeMidia: "Harry Potter e a Pedra Filosofal",
            fotoMidia: "harry_potter",
            categoriaMidia: "Filme",
            generoMidia: "Fantasia",
            paisMidia: "Reino Unido"
        ),
        
        Midia(
            idMidia: 3,
            nomeMidia: "Interestelar",
            fotoMidia: "interestelar",
            categoriaMidia: "Filme",
            generoMidia: "Ficção científica",
            paisMidia: "Estados Unidos"
        ),
        
        Midia(
            idMidia: 4,
            nomeMidia: "Matrix",
            fotoMidia: "matrix",
            categoriaMidia: "Filme",
            generoMidia: "Ficção científica/Ação",
            paisMidia: "Estados Unidos"
        ),
        
        Midia(
            idMidia: 5,
            nomeMidia: "Homem-Aranha: Sem Volta Para Casa",
            fotoMidia: "homem_aranha",
            categoriaMidia: "Filme",
            generoMidia: "Ação/Aventura",
            paisMidia: "Estados Unidos"
        ),
        
        Midia(
            idMidia: 6,
            nomeMidia: "Vingadores: Ultimato",
            fotoMidia: "vingadores",
            categoriaMidia: "Filme",
            generoMidia: "Ação/Ficção científica",
            paisMidia: "Estados Unidos"
        ),
        
        Midia(
            idMidia: 7,
            nomeMidia: "O Batman",
            fotoMidia: "batman",
            categoriaMidia: "Filme",
            generoMidia: "Ação/Crime",
            paisMidia: "Estados Unidos"
        ),
        
        Midia(
            idMidia: 8,
            nomeMidia: "Coringa",
            fotoMidia: "coringa",
            categoriaMidia: "Filme",
            generoMidia: "Drama/Crime",
            paisMidia: "Estados Unidos"
        ),
        
        Midia(
            idMidia: 9,
            nomeMidia: "Toy Story",
            fotoMidia: "toy_story",
            categoriaMidia: "Filme",
            generoMidia: "Animação/Comédia",
            paisMidia: "Estados Unidos"
        ),
        
        Midia(
            idMidia: 10,
            nomeMidia: "Shrek",
            fotoMidia: "shrek",
            categoriaMidia: "Filme",
            generoMidia: "Animação/Comédia",
            paisMidia: "Estados Unidos"
        ),
        
        Midia(
            idMidia: 11,
            nomeMidia: "Stranger Things",
            fotoMidia: "stranger_things",
            categoriaMidia: "Série",
            generoMidia: "Ficção científica/Terror",
            paisMidia: "Estados Unidos"
        ),
        
        Midia(
            idMidia: 12,
            nomeMidia: "Breaking Bad",
            fotoMidia: "breaking_bad",
            categoriaMidia: "Série",
            generoMidia: "Drama/Crime",
            paisMidia: "Estados Unidos"
        ),
        
        Midia(
            idMidia: 13,
            nomeMidia: "The Last of Us",
            fotoMidia: "the_last_of_us",
            categoriaMidia: "Série",
            generoMidia: "Drama/Pós-apocalíptico",
            paisMidia: "Estados Unidos"
        ),
        
        Midia(
            idMidia: 14,
            nomeMidia: "The Boys",
            fotoMidia: "the_boys",
            categoriaMidia: "Série",
            generoMidia: "Ação/Super-heróis",
            paisMidia: "Estados Unidos"
        ),
        
        Midia(
            idMidia: 15,
            nomeMidia: "Wandinha",
            fotoMidia: "wandinha",
            categoriaMidia: "Série",
            generoMidia: "Comédia/Fantasia",
            paisMidia: "Estados Unidos"
        ),
        
        Midia(
            idMidia: 16,
            nomeMidia: "The Office",
            fotoMidia: "the_office",
            categoriaMidia: "Série",
            generoMidia: "Comédia",
            paisMidia: "Estados Unidos"
        ),
        
        Midia(
            idMidia: 17,
            nomeMidia: "Game of Thrones",
            fotoMidia: "game_of_thrones",
            categoriaMidia: "Série",
            generoMidia: "Fantasia/Drama",
            paisMidia: "Estados Unidos"
        ),
        
        Midia(
            idMidia: 18,
            nomeMidia: "Round 6",
            fotoMidia: "round_6",
            categoriaMidia: "Série",
            generoMidia: "Drama/Suspense",
            paisMidia: "Coreia do Sul"
        ),
        
        Midia(
            idMidia: 19,
            nomeMidia: "Arcane",
            fotoMidia: "arcane",
            categoriaMidia: "Série",
            generoMidia: "Animação/Fantasia",
            paisMidia: "Estados Unidos"
        ),
        
        Midia(
            idMidia: 20,
            nomeMidia: "Cobra Kai",
            fotoMidia: "cobra_kai",
            categoriaMidia: "Série",
            generoMidia: "Ação/Comédia",
            paisMidia: "Estados Unidos"
        )
    ]
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    // =========================
                    // FILMES
                    // =========================
                    
                    Text("FILMES")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    
                    LazyVStack(spacing: 8) {
                        
                        ForEach(
                            conteudos.filter {
                                $0.categoriaMidia == "Filme"
                            },
                            id: \.idMidia
                        ) { conteudo in
                            
                            NavigationLink {
                                
                                VStack(spacing: 20) {
                                    
                                    Image(conteudo.fotoMidia)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(
                                            width: 250,
                                            height: 300
                                        )
                                    
                                    Text(conteudo.nomeMidia)
                                        .font(.title)
                                        .bold()
                                    
                                    Text(
                                        "Categoria: \(conteudo.categoriaMidia)"
                                    )
                                    
                                    Text(
                                        "Gênero: \(conteudo.generoMidia)"
                                    )
                                    
                                    Text(
                                        "País: \(conteudo.paisMidia)"
                                    )
                                }
                                .padding()
                                
                            } label: {
                                
                                HStack {
                                    
                                    // Imagem
                                    Image(conteudo.fotoMidia)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(
                                            width: 55,
                                            height: 55
                                        )
                                        .clipShape(
                                            RoundedRectangle(
                                                cornerRadius: 5
                                            )
                                        )
                                    
                                    // Nome e informações
                                    VStack(
                                        alignment: .leading,
                                        spacing: 3
                                    ) {
                                        
                                        Text(conteudo.nomeMidia)
                                            .font(.headline)
                                            .foregroundStyle(.primary)
                                        
                                        Text(conteudo.paisMidia)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(8)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 8
                                    )
                                    .fill(.background)
                                    .shadow(
                                        radius: 4
                                    )
                                )
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    
                    // =========================
                    // SÉRIES
                    // =========================
                    
                    Text("SÉRIES")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    LazyVStack(spacing: 8) {
                        
                        ForEach(
                            conteudos.filter {
                                $0.categoriaMidia == "Série"
                            },
                            id: \.idMidia
                        ) { conteudo in
                            
                            NavigationLink {
                                
                                VStack(spacing: 20) {
                                    
                                    Image(conteudo.fotoMidia)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(
                                            width: 250,
                                            height: 300
                                        )
                                    
                                    Text(conteudo.nomeMidia)
                                        .font(.title)
                                        .bold()
                                    
                                    Text(
                                        "Categoria: \(conteudo.categoriaMidia)"
                                    )
                                    
                                    Text(
                                        "Gênero: \(conteudo.generoMidia)"
                                    )
                                    
                                    Text(
                                        "País: \(conteudo.paisMidia)"
                                    )
                                }
                                .padding()
                                
                            } label: {
                                
                                HStack {
                                    
                                    // Imagem
                                    Image(conteudo.fotoMidia)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(
                                            width: 55,
                                            height: 55
                                        )
                                        .clipShape(
                                            RoundedRectangle(
                                                cornerRadius: 5
                                            )
                                        )
                                    
                                    // Nome e informações
                                    VStack(
                                        alignment: .leading,
                                        spacing: 3
                                    ) {
                                        
                                        Text(conteudo.nomeMidia)
                                            .font(.headline)
                                            .foregroundStyle(.primary)
                                        
                                        Text(conteudo.paisMidia)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(8)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 8
                                    )
                                    .fill(.background)
                                    .shadow(
                                        radius: 4
                                    )
                                )
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Catálogo")
        }
    }
}

#Preview {
    ContentView()
}
