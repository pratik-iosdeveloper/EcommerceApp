//
//  StoreItem.swift
//  EcommerceApp
//
//  Created by Pratik on 22/06/22.
//

import Foundation

struct Store {
    let items: [StoreItem]
}

struct StoreItem {
    let id: String
    let name: String
    let address: String
    let phone: String
    let website: String
}
