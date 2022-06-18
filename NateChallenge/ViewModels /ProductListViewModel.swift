//
//  ProductListViewModel.swift
//  NateChallenge
//
//  Created by Amy Ha on 14/06/2022.
//
import Combine

class ProductListViewModel {
    
    var service: NetworkServiceProtocol = NetworkService()
    var isPaginating = false
    private var currentPage = 1
    
    // maybe there is a way to retrieve the max number of products?
    private var maxProducts = 30
    
    @Published private(set) var products = [Product]()
    
    init() {
        fetchProducts()
    }
    
    var itemsToLoad: Int {
        // We have a max of 4 products per page
        return currentPage*4
    }
    
    func fetchProducts() {
        service.fetchData(with: Constants.Service.offsetURL, itemsToLoad: itemsToLoad) { [weak self] (result: Result<Products, Error>) in
            switch result {
            case .success(let successValue):
                // Ideally, I'd want to append to the array rather than assigning new data every time
                self?.products = successValue.products
                self?.isPaginating = false
                print("success! \(successValue.products.count)")
            case .failure(let failureValue):
                print("failure! \(failureValue)")
                self?.isPaginating = false
            }
        }
    }
    
    func remove(_ product: Product) {
        if let index = products.firstIndex(of: product) {
            products.remove(at: index)
        }
    }
    
    func loadNextPage() {
        self.isPaginating = true
        if itemsToLoad < maxProducts {
            currentPage += 1
            fetchProducts()
        }
    }
}
