//
//  ContentView.swift
//  aula_navigation_stack
//
//  Created by Turma01-2 on 24/08/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 20) {
                
                NavigationLink("Perfil") {
                    Text("Perfil, ue")
                }
                
                NavigationLink("Configurações") {
                    Text("Ta querendo mudar o que?")
                }
                
                NavigationLink("Sobre") {
                    Text("App feito por um estudante com muito pouco tempo pra terminar")
                }
            }
            .navigationTitle("Início")
        }
    }
}

#Preview {
    ContentView()
}
