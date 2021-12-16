//
//  CastApp.swift
//  Cast
//
//  Created by Nick Berendsen on 16/12/2021.
//

import SwiftUI

@main
struct CastApp: App {
    
    @StateObject var caster = Caster()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(caster)
                .frame(width: 400, height: 400)
        }
    }
}
