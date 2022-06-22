//
//  ProductItem.swift
//  EcommerceApp
//
//  Created by Pratik on 22/06/22.
//

import Foundation

struct Product {
    let items: [ProductItem]
}

struct ProductItem {
    let id: String
    let name: String
    let price: String
}
