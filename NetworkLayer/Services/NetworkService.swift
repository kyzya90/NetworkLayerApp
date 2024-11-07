import Combine
import Foundation
import UIKit

enum NetworkError: Error {
    case invalidUrl
    case unknown
    case invalidStatusCode
}

protocol NetworkServiceType {
    func response<T: Decodable>(for request: URLRequest) async throws -> T
    func responsePublisher<T: Decodable>(for requrest: URLRequest) -> AnyPublisher<T, NetworkError>
    func image(with url: URL) async throws -> UIImage
}

final class NetworkService: NetworkServiceType {

    private let urlSession: URLSession
    private let decoder: JSONDecoder

    init(urlSession: URLSession) {
        self.urlSession = urlSession
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .iso8601
        self.decoder = jsonDecoder
    }

    func response<T>(for request: URLRequest) async throws -> T where T : Decodable {
        do {
            let task = try await urlSession.data(for: request)
            return try decoder.decode(T.self, from: task.0)
        } catch {
            throw NetworkError.unknown
        }
    }

    func image(with url: URL) async throws -> UIImage {
        return UIImage()
    }

    func responsePublisher<T: Decodable>(for requrest: URLRequest) -> AnyPublisher<T, NetworkError> {
        return urlSession.dataTaskPublisher(for: requrest)
            .tryMap { (data: Data, response: URLResponse) in
                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode
                else {
                    throw NetworkError.invalidStatusCode
                }

                return data
            }.decode(type: T.self, decoder: decoder)
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
}
