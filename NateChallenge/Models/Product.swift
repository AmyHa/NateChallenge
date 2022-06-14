//
//  Product.swift
//  NateChallenge
//
//  Created by Amy Ha on 14/06/2022.
//

struct Products: Decodable {
    var products: [Product]
}

struct Product: Decodable {
    var id: String
    var title: String
    var images: [String]
    var merchant: String
}
