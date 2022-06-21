//
//  NetworkService.swift
//  NateChallenge
//
//  Created by Amy Ha on 14/06/2022.
//

import Foundation

class NetworkService {
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchData<T:Decodable>(with urlString: String, itemsToLoad: Int, completion: @escaping (Result<T,Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.post.rawValue
        //Request Body
        let json: [String: Any] = ["take": itemsToLoad]
         
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        request.httpBody = jsonData
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { data, _, error in
            
            if let error = error {
                print("Error fetching data: \(error)")
            }
            if let data = data {
                print(data)
                completion(Result{ try JSONDecoder().decode(T.self, from: data)})
            }
        }.resume()
    }
}

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

protocol NetworkServiceProtocol {
    func fetchData<T:Decodable>(with urlString: String, itemsToLoad: Int, completion: @escaping (Result<T,Error>) -> Void)
}

extension NetworkService: NetworkServiceProtocol {}
