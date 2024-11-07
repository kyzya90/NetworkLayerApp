//
//  NetworkLayerApp.swift
//  NetworkLayer
//
//  Created by Aleksandr Kazmin on 07.11.2024.
//

import SwiftUI

@main
struct NetworkLayerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: NetworkLayerViewModel(networkService: NetworkService(urlSession: URLSession.shared)))
        }
    }
}
