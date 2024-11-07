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
                .redacted(reason: .placeholder)
            Text("Hello, world!")
                .redacted(reason: .placeholder)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    class VMStub: NetworkLayerViewModelType {
        var state: NetworkLayerViewModelState = .noContent
        
        func fetchData() {
        }
    }

    static var previews: some View {
        ContentView(viewModel: VMStub())
    }
}
