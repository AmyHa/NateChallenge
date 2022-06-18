//
//  ProductListViewModelTests.swift
//  NateChallengeTests
//
//  Created by Amy Ha on 15/06/2022.
//

import XCTest
@testable import NateChallenge

class ProductListViewModelTests: XCTestCase {
    
    var viewModel: ProductListViewModel!
    
    override func setUpWithError() throws {
        viewModel = ProductListViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func test_remove_shouldRemoveTheProductFromProductsArray() {
        viewModel.service = MockNetworkService()
        viewModel.fetchProducts()
        
        let firstProduct = Product(id: "1", title: "Test shoes", images: [""], merchant: "A&F")
        let secondProduct = Product(id: "2", title: "Test shirt", images: [""], merchant: "Gap")
                
        var expectedCount = 2
        var returnedCount = viewModel.products.count
        
        XCTAssertEqual(expectedCount, returnedCount)
        
        viewModel.remove(firstProduct)
        
        expectedCount = 1
        returnedCount = viewModel.products.count
        
        XCTAssertEqual(expectedCount, returnedCount)
    }
    
    func test_numberOfItemsToLoad_shouldReturnCorrectNumberOfItemsOnFirstPage() {
        let expectedNumber = 4
        let returnedNumber = viewModel.itemsToLoad
        
        XCTAssertEqual(expectedNumber, returnedNumber)
    }
}

// MARK: Mocks classes for testing

class MockNetworkService: NetworkServiceProtocol {
    
    func fetchData<T>(with urlString: String, itemsToSkip: Int, itemsToLoad: Int, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let firstProduct = Product(id: "1", title: "Test shoes", images: [""], merchant: "A&F")
        let secondProduct = Product(id: "2", title: "Test shirt", images: [""], merchant: "Gap")
        let products = Products(products: [firstProduct, secondProduct])
        completion(Result{products as! T})
    }
}
