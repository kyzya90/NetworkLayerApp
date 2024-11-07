import Foundation
import Combine

enum NetworkLayerViewModelState: Equatable {
    static func == (lhs: NetworkLayerViewModelState, rhs: NetworkLayerViewModelState) -> Bool {
        switch (lhs, rhs) {
        case (.noContent, .noContent):
            return true
        case (.loading, .loading):
            return true
        case (.failed, .failed):
            return true
        case (.loaded, .loaded):
            return true
        default:
            return false
        }
    }

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
    @Published var state: NetworkLayerViewModelState = .loading
    private let networkService: MainScreenNetworkServiceType
    private var cancelBag: Set<AnyCancellable> = []

    init(networkService: MainScreenNetworkServiceType) {
        self.networkService = networkService
    }

    func fetchData() {
        state = .loading
        let header = networkService.headerPublisher()
        let body = networkService.bodyPublisher()
        let zip = Publishers.Zip(header, body)
        zip
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .success(let items):
                    self.state = .loaded(NetworkLayerScreenModel(header: items.0,
                                                                 body: items.1))
                case .failure(let error):
                    self.state = .failed
                }
            }.store(in: &cancelBag)

    }
}
