//
//  OrderItem.swift
//  EcommerceApp
//
//  Created by Pratik on 22/06/22.
//

import Foundation

struct Order: Codable {
    let items: [OrderItem]
    let totalPrice: String
    let deliveryAddress: String
    
    enum CodingKeys: String, CodingKey {
        case items, totalPrice, deliveryAddress
    }
}

struct OrderItem: Codable {
    let id: String
    let name: String
    let price: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, price
    }
}
