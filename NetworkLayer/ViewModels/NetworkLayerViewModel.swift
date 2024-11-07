import Foundation
import Combine

enum NetworkLayerViewModelState {
    case noContent
    case loading
    case loaded(NetworkLayerScreenModel)
    case failed
}

protocol NetworkLayerViewModelType: ObservableObject {
    func fetchData()
    var state: NetworkLayerViewModelState { get set }
}

class NetworkLayerViewModel: NetworkLayerViewModelType {
    @Published var state: NetworkLayerViewModelState = .noContent
    private let networkService: NetworkServiceType

    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }

    func fetchData() {
    }
}
