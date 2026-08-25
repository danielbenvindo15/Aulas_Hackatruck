//
//  ContentView.swift
//  ZStacks
//
//  Created by Turma01-2 on 14/08/26.
//

import SwiftUI

struct ContentView: View {
    @State private var exibirAlerta = false
    var body: some View {
        VStack {
            Text("Bem vindo," )
                .font(.title)
            Spacer()
            Text("Bem vindo a nossa plataforma")
                .foregroundStyle(.gray)
            Spacer()
            Image("pngtree-anime-night-scenery-image_17276446")
                .resizable()
                .frame(width: 550 ,height: 550)
            Spacer()
            Button("Clique Aqui") {
                exibirAlerta = true
            }
            
            .alert("Voce Clicou!", isPresented: $exibirAlerta) {
                Button("Sair", role: .destructive) {}
            }message: {
                Text("Deseja sair?")
            }
    
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
