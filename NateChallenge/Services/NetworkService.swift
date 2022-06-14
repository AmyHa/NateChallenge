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
    
    func fetchData<T:Decodable>(with urlString: String, completion: @escaping (Result<T,Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.post.rawValue
        
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

enum HttpMethods: String {
    case post = "POST"
    case get = "GET"
}

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
