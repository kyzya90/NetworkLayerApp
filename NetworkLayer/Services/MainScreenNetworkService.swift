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
        guard let requiredUrl = URL(string: "https://gist.githubusercontent.com/Disconnecter/ba9872ace953e382b3497ba358940ca9/raw/90f9f3344b0539a71e7abcb69578c6dadb817a86/gistfile1.txt")
        else { return Fail<Header, NetworkError>(error: NetworkError.invalidUrl).eraseToAnyPublisher() }
        let urlRequest = URLRequest(url: requiredUrl)
        return networkService.responsePublisher(for: urlRequest)
    }

    func bodyPublisher() -> AnyPublisher<Body, NetworkError> {
        guard let requiredUrl = URL(string: "https://gist.githubusercontent.com/Disconnecter/ba9872ace953e382b3497ba358940ca9/raw/90f9f3344b0539a71e7abcb69578c6dadb817a86/gistfile1.txt")
        else { return Fail<Body, NetworkError>(error: NetworkError.invalidUrl).eraseToAnyPublisher() }
        let urlRequest = URLRequest(url: requiredUrl)
        return networkService.responsePublisher(for: urlRequest)
    }
}
