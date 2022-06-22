//
//  StoreItem.swift
//  EcommerceApp
//
//  Created by Pratik on 22/06/22.
//

import Foundation

struct Store: Codable {
    let items: [StoreItem]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

struct StoreItem: Codable {
    let id: String
    let name: String
    let address: String
    let phone: String
    let website: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, address, phone, website
    }
}
