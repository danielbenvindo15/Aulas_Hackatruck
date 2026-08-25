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
                HStack(spacing: 20){
                    
                    //Rosa
                    NavigationLink() {
                        
                        
                     /// Icone
                    }label:{
                        ZStack {
                            Rectangle()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(.pink)
                                
                            Image(systemName: "paintbrush")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .foregroundStyle(.white)
                        }
                    }
                    
                    NavigationLink("Configurações") {
                        Text("Ta querendo mudar o que?")
                    }la
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
