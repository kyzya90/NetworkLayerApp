import Combine
import Foundation
import UIKit

enum NetworkError: Error {
    case invalidUrl
    case unknown
}

protocol NetworkServiceType {
    func response<T: Decodable>(for request: URLRequest) async throws -> T
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
}
