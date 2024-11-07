//
//  mainScreenNetworkService.swift
//  NetworkLayer
//
//  Created by Aleksandr Kazmin on 07.11.2024.
//

import Foundation
import Combine

protocol MainScreenNetworkServiceType {
    func headerPublisher() -> AnyPublisher<Header, NetworkError>
    func bodyPublisher() -> AnyPublisher<Body, NetworkError>
}

final class MainScreenNetworkService: MainScreenNetworkServiceType {
    private let networkService: NetworkServiceType

    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }

    func headerPublisher() -> AnyPublisher<Header, NetworkError> {
        guard let requiredUrl = URL(string: "https://google.com")
        else { return Fail<Header, NetworkError>(error: NetworkError.invalidUrl).eraseToAnyPublisher() }
        let urlRequest = URLRequest(url: requiredUrl)
        return networkService.responsePublisher(for: urlRequest)
    }

    func bodyPublisher() -> AnyPublisher<Body, NetworkError> {
        guard let requiredUrl = URL(string: "https://google.com")
        else { return Fail<Body, NetworkError>(error: NetworkError.invalidUrl).eraseToAnyPublisher() }
        let urlRequest = URLRequest(url: requiredUrl)
        return networkService.responsePublisher(for: urlRequest)
    }
}
