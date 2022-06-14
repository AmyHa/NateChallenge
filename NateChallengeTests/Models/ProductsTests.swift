//
//  ProductsTests.swift
//  NateChallengeTests
//
//  Created by Amy Ha on 14/06/2022.
//
import XCTest
@testable import NateChallenge

class ProductsTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_init_setsID() {
        let product = Product(id: "123", title: "", images: [String](), merchant: "")
        
        XCTAssertEqual(product.id, "123")
    }
    
    func test_init_setsTitle() {
        let product = Product(id: "123", title: "Island Punch Bath Bomb", images: [String](), merchant: "")

        XCTAssertEqual(product.title, "Island Punch Bath Bomb")
    }

    func test_init_setsImages() {
        let product = Product(id: "123", title: "", images: ["https://www.oldwhalingcompany.com/mm5/graphics/00000001/Island-Punch-Bath-Bomb-POW-960.png"], merchant: "")

        XCTAssertEqual(product.images, ["https://www.oldwhalingcompany.com/mm5/graphics/00000001/Island-Punch-Bath-Bomb-POW-960.png"])
    }

    func test_init_setsMerchant() {
        let product = Product(id: "123", title: "Island Punch Bath Bomb", images: [String](), merchant: "www.oldwhalingcompany.com")

        XCTAssertEqual(product.merchant, "www.oldwhalingcompany.com")
    }
    
    func test_decodeObject_successfulDecodeProducts() throws {
        
        let decoder = JSONDecoder()
        
        let data = try decoder.decode(Products.self, from: XCTUnwrap(mockProductsData))
        
        XCTAssertEqual(data.products[0].id, "8553a370-8ff3-402d-b8a4-64b18949b36d")
        XCTAssertEqual(data.products[0].title, "Ultra High Rise Ankle Straight Jeans")
        XCTAssertEqual(data.products[0].images, [])
        XCTAssertEqual(data.products[0].merchant, "Abercrombie & Fitch")
        
        XCTAssertEqual(data.products[1].id, "579d7e46-ddbc-4a6c-9bff-530444205a1f")
        XCTAssertEqual(data.products[1].title, "La Sélection Nomade")
        XCTAssertEqual(data.products[1].images, [
            "https://media-live.byredo.com/media/catalog/product/optimized/8/5/8529df057ba542031c76db2227539212ccfb359560579b72c48c9f95905e385f/mob_la-selection-nomade-3x12-ml_1_1.jpg"])
        XCTAssertEqual(data.products[1].merchant, "https://www.byredo.com/us_en/la-selection-nomade-eau-de-parfum-3x12ml")
    }
}

extension ProductsTests {
    var mockProductsData: Data? {
        """
        {
            "products": [
                {
                  "id": "8553a370-8ff3-402d-b8a4-64b18949b36d",
                  "title": "Ultra High Rise Ankle Straight Jeans",
                  "images": [],
                  "merchant": "Abercrombie & Fitch"
                },
                {
                  "id": "579d7e46-ddbc-4a6c-9bff-530444205a1f",
                  "title": "La Sélection Nomade",
                  "images": [
                    "https://media-live.byredo.com/media/catalog/product/optimized/8/5/8529df057ba542031c76db2227539212ccfb359560579b72c48c9f95905e385f/mob_la-selection-nomade-3x12-ml_1_1.jpg"],
                  "merchant": "https://www.byredo.com/us_en/la-selection-nomade-eau-de-parfum-3x12ml"
                }
            ]
        }
        """.data(using: .utf8)
    }
}
