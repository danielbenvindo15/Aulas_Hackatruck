import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let nome: String
}

struct ListaView: View {
    let frutas: [Item] = [
        Item(nome: "Maçã"),
        Item(nome: "Banana"),
        Item(nome: "Laranja"),
        Item(nome: "Uva")
    ]

    var body: some View {
        List(frutas) { fruta in
            Text(fruta.nome)
        }
    }
}
struct ContentView: View {
    var body: some View {
        TabView {
            VStack {
                
            //-------------- Rosa -----------------//
                ZStack {
                    Circle()
                        .frame(width: 250, height: 250)
                    Image(systemName: "paintbrush")
                        .resizable()
                        .foregroundStyle(.pink)
                        .frame(width: 150,height: 150)
                }
                
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background(Color.pink)
            }
           
                .tabItem {
                    Label("Rosa", systemImage: "paintbrush.fill")
                }
            
            //---------------- Azul ----------------//
            VStack{
                ZStack {
                    Circle()
                        .frame(width: 250, height: 250)
                    
                    Image(systemName: "paintbrush.pointed")
                        .resizable()
                        .foregroundStyle(.blue)
                        .frame(width: 150, height: 150)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)
            }
                .tabItem {
                    Label("Azul",  systemImage: "paintbrush.pointed.fill")
                }
            
            VStack{
                ZStack {
                    Circle()
                        .frame(width: 250, height: 250)
                    
                    Image(systemName: "paintpalette")
                        .resizable()
                        .foregroundStyle(.gray)
                        .scaledToFit()
                        .frame(width: 150 , height: 150)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray)
            }
                .tabItem {
                    Label("Cinza", systemImage: "paintpalette.fill")
                }
            
            VStack{
                Text("Lista")
                ZStack {
                    
                    ListaView()
                        .tabItem {
                            Label("Lista", systemImage: "list.bullet")
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
            }
                .tabItem {
                    Label("Lista", systemImage: "list.bullet")
                }
        }
    }
}

#Preview {
    ContentView()
}
