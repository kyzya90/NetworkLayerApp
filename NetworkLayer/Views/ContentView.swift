//
//  ContentView.swift
//  NetworkLayer
//
//  Created by Aleksandr Kazmin on 07.11.2024.
//
import Foundation
import SwiftUI

struct ContentView<T: NetworkLayerViewModelType>: View {
    @ObservedObject private var viewModel: T

    init(viewModel: T) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .redacted(reason: $viewModel.state.wrappedValue == .loading ? .placeholder : [])
        .padding()
        .onAppear(perform: {
            viewModel.fetchData()
        }).alert("Something went wrong",
                 isPresented: Binding(get: {$viewModel.state.wrappedValue == .failed},
                                      set: { _ in })) {
            Button("OK", role: .cancel) {}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    class VMStub: NetworkLayerViewModelType {
        var state: NetworkLayerViewModelState = .noContent

        func fetchData() {

            state = .loading
        }
    }

    static var previews: some View {
        ContentView(viewModel: VMStub())
    }
}
