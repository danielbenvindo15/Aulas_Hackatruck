import SwiftUI
import MapKit

// MARK: - Modelo

struct Location: Identifiable {
    
    let id = UUID()
    let nome: String
    let descricao: String
    let imagem: String
    let pais: String
    let regiao: String
    let coordenada: CLLocationCoordinate2D
}


// MARK: - ContentView

struct ContentView: View {
    
    // MARK: - 7 Maravilhas do Mundo
    
    let locations = [
        
        Location(
            nome: "Cristo Redentor",
            descricao: "Localizado no Rio de Janeiro, Brasil, o Cristo Redentor é uma das construções mais conhecidas do mundo e possui uma das vistas mais famosas da cidade.",
            imagem: "https://rederiohoteis.com/wp-content/uploads/2017/09/2017-10-29-cristo-redentor-conheca-a-historia-dessa-maravilha-do-mundo-moderno2.jpg.webp",
            pais: "Brasil",
            regiao: "América",
            coordenada: CLLocationCoordinate2D(
                latitude: -22.9519,
                longitude: -43.2105
            )
        ),
        
        Location(
            nome: "Machu Picchu",
            descricao: "Antiga cidade inca localizada nas montanhas do Peru. É um dos sítios arqueológicos mais famosos do mundo.",
            imagem: "https://visitsouthamerica.co/wp-content/uploads/2021/07/IMG_1433-3.jpg",
            pais: "Peru",
            regiao: "América",
            coordenada: CLLocationCoordinate2D(
                latitude: -13.1631,
                longitude: -72.5450
            )
        ),
        
        Location(
            nome: "Chichén Itzá",
            descricao: "Grande cidade maia localizada na Península de Yucatán, no México. Sua construção mais famosa é a pirâmide de Kukulcán.",
            imagem: "https://p2.trrsf.com/image/fget/cf/1200/1600/middle/images.terra.com/2024/04/09/683381966-luis-aceves-zn5ucumho2u-unsplash.jpg",
            pais: "México",
            regiao: "América",
            coordenada: CLLocationCoordinate2D(
                latitude: 20.6843,
                longitude: -88.5678
            )
        ),
        
        Location(
            nome: "Coliseu",
            descricao: "Grande anfiteatro construído durante o Império Romano e localizado no centro de Roma, na Itália.",
            imagem: "https://img.magnific.com/fotos-premium/vista-do-coliseu-romano-coliseu-romano-em-roma-lazio-italia_137125-2984.jpg?semt=ais_hybrid&w=740&q=80",
            pais: "Itália",
            regiao: "Europa",
            coordenada: CLLocationCoordinate2D(
                latitude: 41.8902,
                longitude: 12.4922
            )
        ),
        
        Location(
            nome: "Petra",
            descricao: "Antiga cidade escavada nas rochas, localizada na Jordânia. É conhecida por sua arquitetura e importância histórica.",
            imagem: "https://media-cdn.tripadvisor.com/media/attractions-splice-spp-674x446/0b/91/e3/49.jpg",
            pais: "Jordânia",
            regiao: "Ásia",
            coordenada: CLLocationCoordinate2D(
                latitude: 30.3285,
                longitude: 35.4444
            )
        ),
        
        Location(
            nome: "Taj Mahal",
            descricao: "Grande mausoléu localizado em Agra, na Índia, conhecido por sua arquitetura em mármore branco.",
            imagem: "https://lulimonteleone.com/wp-content/uploads/2019/05/Taj-mahal-india.jpg.webp",
            pais: "Índia",
            regiao: "Ásia",
            coordenada: CLLocationCoordinate2D(
                latitude: 27.1751,
                longitude: 78.0421
            )
        ),
        
        Location(
            nome: "Grande Muralha da China",
            descricao: "Sistema de fortificações construído ao longo de diferentes períodos da história chinesa.",
            imagem: "https://static.nationalgeographicbrasil.com/files/styles/image_3200/public/nationalgeographic2710344.jpg?w=1900&h=1272",
            pais: "China",
            regiao: "Ásia",
            coordenada: CLLocationCoordinate2D(
                latitude: 40.4319,
                longitude: 116.5704
            )
        )
    ]
    
    
    // MARK: - Estados
    
    @State private var regiaoSelecionada = 0
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 20,
                longitude: 0
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 80,
                longitudeDelta: 80
            )
        )
    )
    
    @State private var localSelecionado: Location?
    
    
    // MARK: - Body
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                // MARK: Picker
                
                Picker(
                    "Região",
                    selection: $regiaoSelecionada
                ) {
                    
                    Text("Todos")
                        .tag(0)
                    
                    Text("América")
                        .tag(1)
                    
                    Text("Europa")
                        .tag(2)
                    
                    Text("Ásia")
                        .tag(3)
                }
                .pickerStyle(.segmented)
                .padding()
                
                .background(Color(red: 1.0 , green: 0.9, blue: 0.63))
                
                
                // MARK: Mapa
                
                Map(position: $cameraPosition) {
                    
                    ForEach(locaisFiltrados) { location in
                        
                        Annotation(
                            location.nome,
                            coordinate: location.coordenada
                        ) {
                            
                            Button {
                                localSelecionado = location
                            } label: {
                                
                                Image(
                                    systemName: "mappin.circle.fill"
                                )
                                .font(.system(size: 35))
                                .foregroundStyle(.red)
                                .background(.white)
                                .clipShape(Circle())
                            }
                        }
                    }
                }
            }
            
            .navigationTitle("7 Maravilhas")
            
            
            // MARK: Sheet
            
            .sheet(item: $localSelecionado) { local in
                
                SheetView(
                    local: local
                )
            }
            
            
            // MARK: Mudança de região
            
            .onChange(of: regiaoSelecionada) {
                
                mudarRegiao()
            }
        }
    }
    
    
    // MARK: - Locais filtrados
    
    var locaisFiltrados: [Location] {
        
        switch regiaoSelecionada {
            
        case 1:
            return locations.filter {
                $0.regiao == "América"
            }
            
        case 2:
            return locations.filter {
                $0.regiao == "Europa"
            }
            
        case 3:
            return locations.filter {
                $0.regiao == "Ásia"
            }
            
        default:
            return locations
        }
    }
    
    
    // MARK: - Mudar região
    
    func mudarRegiao() {
        
        switch regiaoSelecionada {
            
        case 0:
            
            // Mundo inteiro
            
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: 20,
                        longitude: 0
                    ),
                    span: MKCoordinateSpan(
                        latitudeDelta: 80,
                        longitudeDelta: 80
                    )
                )
            )
            
            
        case 1:
            
            // América
            
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: 0,
                        longitude: -60
                    ),
                    span: MKCoordinateSpan(
                        latitudeDelta: 50,
                        longitudeDelta: 50
                    )
                )
            )
            
            
        case 2:
            
            // Europa
            
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: 45,
                        longitude: 10
                    ),
                    span: MKCoordinateSpan(
                        latitudeDelta: 30,
                        longitudeDelta: 30
                    )
                )
            )
            
            
        case 3:
            
            // Ásia
            
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: 30,
                        longitude: 80
                    ),
                    span: MKCoordinateSpan(
                        latitudeDelta: 50,
                        longitudeDelta: 50
                    )
                )
            )
            
            
        default:
            break
        }
    }
}


#Preview {
    ContentView()
}
