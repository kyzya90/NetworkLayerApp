//
//  NetworkLayerApp.swift
//  NetworkLayer
//
//  Created by Aleksandr Kazmin on 07.11.2024.
//

import SwiftUI

@main
struct AppLauncher {

    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            NetworkLayerApp.main()
        } else {
            TestApp.main()
        }
    }
}

struct TestApp: App {

    var body: some Scene {
        WindowGroup { Text("Running Unit Tests") }
    }
}

struct NetworkLayerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: NetworkLayerViewModel(networkService: MainScreenNetworkService(networkService: NetworkService(urlSession: URLSession.shared))))
        }
    }
}
