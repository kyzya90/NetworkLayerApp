//
//  NetworkClientTests.swift
//  NetworkLayerTests
//
//  Created by Aleksandr Kazmin on 08.11.2024.
//

import XCTest
import Combine
@testable import NetworkLayer

class NetworkClientTests: XCTestCase {

    private var networkService: NetworkService!
    private var cancelBag: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        networkService = NetworkService(urlSession: urlSession)
    }

    override func tearDown() {
        super.tearDown()
        MockURLProtocol.requestHandler = nil
    }

    func testResponsePublisherOnSuccess() {
        // GIVEN
        let expectation = XCTestExpectation(description: "testResponsePublisherOnSuccess exp")
        let response = headerResponse(url: testHeaderUrl())
        let data =  mockData(for: "Header")
        setupRequestHandler(with: (response, data))

        let header: AnyPublisher<Header, NetworkError> = networkService.responsePublisher(for: URLRequest(url: testHeaderUrl()))
        // WHEN
        header.sink { result in
            // THEN
            switch result {
            case .success(let header):
                XCTAssertEqual(header.title, "Car Models Collection")
                XCTAssertEqual(header.version, "1.0")
                XCTAssertEqual(header.imageUrl, "https://example.com/car-models")
            case .failure: XCTFail("unreachable for this test")
            }
            expectation.fulfill()
        }.store(in: &cancelBag)
        wait(for: [expectation], timeout: 1.0)
    }

    func testResponsePublisherOnFailure() {
        // GIVEN
        let expectation = XCTestExpectation(description: "testResponsePublisherOnFailure exp")
        let response = headerResponse(with: 404,
                                      url: testHeaderUrl())
        let data =  mockData(for: "Header")
        setupRequestHandler(with: (response, data))

        let header: AnyPublisher<Header, NetworkError> = networkService.responsePublisher(for: URLRequest(url: testHeaderUrl()))
        // WHEN
        header.sink { result in
            // THEN
            switch result {
            case .success: XCTFail("Unreachable for this test")
            case .failure: expectation.fulfill()
            }
        }.store(in: &cancelBag)
        wait(for: [expectation], timeout: 1.0)
    }

    func testAsyncOnFailure() async {
        // GIVEN
        let response = headerResponse(with: 404,
                                      url: testHeaderUrl())
        let data =  mockData(for: "Header")
        setupRequestHandler(with: (response, data))

        do {
            // WHEN
            let _: Header = try await networkService.response(for: URLRequest(url: testHeaderUrl()))
            // THEN
            XCTFail("Unreachable for this test")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testAsyncOnSuccess() async {
        // GIVEN
        let response = headerResponse(url: testHeaderUrl())
        let data =  mockData(for: "Header")
        setupRequestHandler(with: (response, data))

        do {
            let _: Header = try await networkService.response(for: URLRequest(url: testHeaderUrl()))
        } catch {
            XCTFail("Unreachable for this test")
        }
    }

    private func testHeaderUrl() -> URL {
        let url = URL(string: "https://header.com")
        let fallbackUrl = URL(fileURLWithPath: "")
        return url ?? fallbackUrl
    }

    private func headerResponse(with statusCode: Int = 200,
                                url: URL) -> HTTPURLResponse {
        guard let requiredResponse = HTTPURLResponse(url: url,
                                                     statusCode: statusCode,
                                                     httpVersion: nil,
                                                     headerFields: nil)
        else { fatalError("could not create response with url \(url.absoluteString) and statuscode = \(statusCode)") }
        return requiredResponse
    }

    private func setupRequestHandler(with response: (HTTPURLResponse, Data)) {
        MockURLProtocol.requestHandler = { request in
            return response
        }
    }

    private func mockData(for filename: String) -> Data {
        let bundle = Bundle(for: NetworkClientTests.self)
        guard let testFileUrl = bundle.url(forResource: filename, withExtension: "json") else { fatalError("could not create URL with filename =  \(filename)") }
        do {
            let data = try Data(contentsOf: testFileUrl)
            return data
        } catch {
            fatalError("could not get file by name \(filename)")
        }
    }
}
