import Foundation
import Combine

protocol NetworkLayerViewModelType: ObservableObject{
    func fetchData()
}

class NetworkLayerViewModel: NetworkLayerViewModelType {
    private let networkService: NetworkServiceType

    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }

    func fetchData() {

    }
}
