//
//  GustoApp.swift
//  Gusto
//
//  Created by Kyusaku Mihara on 2024/03/24.
//

import SwiftUI
import SwiftData

@main
struct GustoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Restaurant.self)
        }
    }
}
