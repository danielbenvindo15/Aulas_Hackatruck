//
//  testeApp.swift
//  teste
//
//  Created by Turma01-2 on 04/09/26.
//

import SwiftUI
import Firebase

@main
struct testeApp: App {
    init(){
        let provider = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(provider)
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
