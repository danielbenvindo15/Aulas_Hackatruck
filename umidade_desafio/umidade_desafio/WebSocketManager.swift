import Foundation
import Combine

class WebSocketManager: NSObject, ObservableObject {

    @Published var umidade: Int = 0
    @Published var conectado: Bool = false

    private var webSocket: URLSessionWebSocketTask?
    private var session: URLSession?

    func conectar() {

        // IP do NodeMCU
        let ip = "192.168.128.170"

        // WebSocket na porta 81
        guard let url = URL(string: "ws://\(ip):81") else {
            print("URL inválida")
            return
        }

        print("Tentando conectar em: \(url)")

        session = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: OperationQueue()
        )

        webSocket = session?.webSocketTask(with: url)

        webSocket?.resume()

        receberMensagem()
    }

    private func receberMensagem() {

        webSocket?.receive { [weak self] resultado in

            DispatchQueue.main.async {

                guard let self = self else {
                    return
                }

                switch resultado {

                case .success(let mensagem):

                    switch mensagem {

                    case .string(let texto):

                        print("Mensagem recebida: \(texto)")

                        self.processarMensagem(texto)

                    case .data(let dados):

                        if let texto = String(
                            data: dados,
                            encoding: .utf8
                        ) {

                            print("Mensagem recebida: \(texto)")

                            self.processarMensagem(texto)
                        }

                    @unknown default:
                        break
                    }

                    // Continua recebendo mensagens
                    self.receberMensagem()

                case .failure(let erro):

                    print("Erro WebSocket: \(erro)")

                    self.conectado = false
                }
            }
        }
    }

    private func processarMensagem(_ texto: String) {

        guard let dados = texto.data(using: .utf8) else {
            return
        }

        do {

            let resultado = try JSONDecoder().decode(
                Umidade.self,
                from: dados
            )

            // Valor bruto recebido do NodeMCU
            let leitura = resultado.umidade

            // Converte:
            // 0    -> 100%
            // 1023 -> 0%
            let percentual = Int(
                ((1023.0 - Double(leitura)) / 1023.0) * 100.0
            )

            // Garante que fique entre 0 e 100
            let umidadeFinal = max(
                0,
                min(100, percentual)
            )

            DispatchQueue.main.async {

                self.umidade = umidadeFinal
            }

            print("Leitura do sensor: \(leitura)")
            print("Umidade: \(umidadeFinal)%")

        } catch {

            print("Erro ao converter JSON: \(error)")
            print("Mensagem recebida: \(texto)")
        }
    }

    func desconectar() {

        webSocket?.cancel(
            with: .goingAway,
            reason: nil
        )

        webSocket = nil

        session?.invalidateAndCancel()
        session = nil

        DispatchQueue.main.async {

            self.conectado = false
        }
    }
}

extension WebSocketManager: URLSessionWebSocketDelegate {

    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didOpenWithProtocol protocol: String?
    ) {

        DispatchQueue.main.async {

            self.conectado = true

            print("WebSocket conectado!")
        }
    }

    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didCloseWith closeCode: URLSessionWebSocketTask.CloseCode,
        reason: Data?
    ) {

        DispatchQueue.main.async {

            self.conectado = false

            print("WebSocket desconectado!")
        }
    }
}
