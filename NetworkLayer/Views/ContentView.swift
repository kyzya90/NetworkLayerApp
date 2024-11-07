//
//  ContentView.swift
//  NetworkLayer
//
//  Created by Aleksandr Kazmin on 07.11.2024.
//

import SwiftUI

struct ContentView: View {
    private let viewModel: any NetworkLayerViewModelType

    init(viewModel: any NetworkLayerViewModelType) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    class VMStub: NetworkLayerViewModelType {
        func fetchData() {
        }
    }

    static var previews: some View {
        ContentView(viewModel: VMStub())
    }
}
