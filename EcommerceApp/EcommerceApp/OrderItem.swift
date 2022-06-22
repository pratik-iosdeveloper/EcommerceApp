//
//  OrderItem.swift
//  EcommerceApp
//
//  Created by Pratik on 22/06/22.
//

import Foundation

struct Order {
    let items: [OrderItem]
    let totalPrice: String
    let deliveryAddress: String
}

struct OrderItem {
    let id: String
    let name: String
    let price: String
}
