import SwiftUI

struct ContentView: View {

    @StateObject private var webSocket = WebSocketManager()

    var body: some View {

        VStack(spacing: 30) {

            Text("Monitor de Umidade")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 10) {

                Text("Umidade")
                    .font(.headline)

                Text("\(webSocket.umidade)%")
                    .font(
                        .system(
                            size: 60,
                            weight: .bold
                        )
                    )
            }

            HStack {

                Circle()
                    .fill(
                        webSocket.conectado
                        ? Color.green
                        : Color.red
                    )
                    .frame(
                        width: 15,
                        height: 15
                    )

                Text(
                    webSocket.conectado
                    ? "Conectado"
                    : "Desconectado"
                )
            }

            Button("Conectar") {

                webSocket.conectar()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onAppear {

            webSocket.conectar()
        }
    }
}

#Preview {
    ContentView()
}
