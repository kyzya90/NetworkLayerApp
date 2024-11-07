//
//  Publishers.swift
//  NetworkLayer
//
//  Created by Aleksandr Kazmin on 07.11.2024.
//

import Foundation
import Combine

extension Publisher {
    public func sink(receiveResult: @escaping ((Result<Self.Output, Self.Failure>) -> Void)) -> AnyCancellable {
        self.sink { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                receiveResult(.failure(error))
            }
        } receiveValue: { value in
            receiveResult(.success(value))
        }
    }
}
