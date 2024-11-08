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
        switch $viewModel.state.wrappedValue {
        case .failed, .loading, .noContent:
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
        case .loaded(let model):
            List {
                ForEach(model.items) { car in
                    aCell(cellData: car).listRowInsets(EdgeInsets())
                }
            }.listStyle(.plain)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    class VMStub: NetworkLayerViewModelType {
        var state: NetworkLayerViewModelState = .loaded(NetworkLayerScreenModel(header: Header(title: "", version: "", imageUrl: ""), items: [aCellData(title: "some title",
                                                                                                                                                        description: "some description", imageUrl: URL(fileURLWithPath: ""))]))

        func fetchData() {
        }
    }

    static var previews: some View {
        ContentView(viewModel: VMStub())
    }
}
