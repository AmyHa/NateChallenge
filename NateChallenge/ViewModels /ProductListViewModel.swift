//
//  ProductListViewModel.swift
//  NateChallenge
//
//  Created by Amy Ha on 14/06/2022.
//
import Combine

class ProductListViewModel {
    var service = NetworkService()
    @Published private(set) var products = [Product]()
    
    init() {
        fetchProducts()
    }
    
    func fetchProducts() {
        service.fetchData(with: Constants.Service.baseURL) { [weak self] (result: Result<Products, Error>) in
            
            switch result {
            case .success(let successValue):
                self?.products = successValue.products
                print("success! \(successValue)")
            case .failure(let failureValue):
                print("failure! \(failureValue)")
            }
        }
    }
}