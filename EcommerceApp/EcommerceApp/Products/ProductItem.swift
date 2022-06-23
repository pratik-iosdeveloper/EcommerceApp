//
//  ProductItem.swift
//  EcommerceApp
//
//  Created by Pratik on 22/06/22.
//

import Foundation

struct Product: Codable {
    let items: [ProductItem]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

struct ProductItem: Codable {
    let id: String
    let name: String
    let price: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, price
    }
    
    var formattedPrice: String { return "₹\(price)" }
}
