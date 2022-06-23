//
//  HomeScreenUseCaseTests.swift
//  EcommerceAppTests
//
//  Created by Pratik on 23/06/22.
//

import XCTest

class HomeScreenUseCaseTests: XCTestCase {

    func test_load_homeScreenWithStoreDataLoaded() {
        let apiClient = MockAPIClient()
        var storeData: Store?
        apiClient.fetchStores { (success, data) in
            storeData = data
            XCTAssertTrue(storeData!.items.count > 0, "Store items loaded successfully")
        }
    }
    
    func test_load_homeScreenWithProductDataLoaded() {
        let apiClient = MockAPIClient()
        var productData: Product?
        apiClient.fetchProducts { (success, data) in
            productData = data
            XCTAssertTrue(productData!.items.count > 0, "Products loaded successfully")
        }
    }

}
