//
//  ContentView.swift
//  D2
//
//  Created by Turma01-2 on 14/08/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack(spacing: 50){
                Image("image")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    
                Text("Perfil 1")
                    .font(.title)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
