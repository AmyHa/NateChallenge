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
}
