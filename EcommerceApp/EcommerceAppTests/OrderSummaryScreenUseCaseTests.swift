//
//  OrderSummaryScreenUseCaseTests.swift
//  EcommerceAppTests
//
//  Created by Pratik on 23/06/22.
//

import XCTest

class OrderSummaryScreenUseCaseTests: XCTestCase {

    func test_load_orderSummaryScreenWithDataLoaded() {
        let apiClient = MockAPIClient()
        var orderData: Order?
        apiClient.postOrderDetails { (success, data) in
            orderData = data
            XCTAssertTrue(orderData!.items.count > 0, "Order summary loaded successfully")
        }
    }
    
    func test_load_orderSummaryContainsTotalPrice() {
        let apiClient = MockAPIClient()
        var orderData: Order?
        apiClient.postOrderDetails { (success, data) in
            orderData = data
            XCTAssertEqual(orderData!.totalPrice, "100")
        }
    }
    
    func test_load_orderSummaryContainsDeliveryAddress() {
        let apiClient = MockAPIClient()
        var orderData: Order?
        apiClient.postOrderDetails { (success, data) in
            orderData = data
            XCTAssertTrue(orderData!.deliveryAddress.count > 0, "Order summary contains delivery address")
        }
    }
    
}
