//
//  NetworkServiceTests.swift
//  NateChallengeTests
//
//  Created by Amy Ha on 14/06/2022.
//

import XCTest
@testable import NateChallenge

class NetworkServiceTests: XCTestCase {

    var service: NetworkService!
    let session = MockURLSession()
    
    override func setUpWithError() throws {
        self.service = NetworkService(session: session)
    }

    override func tearDownWithError() throws {}

    func test_fetchData_shouldRequestCorrectURL() throws {
        let url = Constants.Service.baseURL
        service.fetchData(with: url, itemsToLoad: 4) { (result: Result<Products, Error>) in
            
        }
        let expectedURL = URL(string: url)
        let returnedURL = session.lastURL
        
        XCTAssertEqual(expectedURL, returnedURL)
    }
}


// MARK: Mocks classes for testing

class MockURLSession: URLSessionProtocol {
    private (set) var lastURL: URL?

    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        lastURL = request.url
        return URLSession.shared.dataTask(with: request.url!)
    }
}
