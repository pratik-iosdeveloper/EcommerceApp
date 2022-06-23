//
//  API.swift
//  EcommerceApp
//
//  Created by Pratik on 22/06/22.
//

import Foundation

protocol API {
    func fetchStores(completion: @escaping (Bool, Store?) -> Void)
    func fetchProducts(completion: @escaping (Bool, Product?) -> Void)
    func postOrderDetails(completion: @escaping (Bool, Order?) -> Void)
}


final class MockAPIClient: API {
    
    private static let delay = 4
    
    func fetchStores(completion: @escaping (Bool, Store?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(MockAPIClient.delay)) {
            let filePath = "StoreInfo"
            MockAPIClient.loadJsonDataFromFile(filePath, completion: { data in
                if let json = data {
                    do {
                        let items = try JSONDecoder().decode(Store.self, from: json)
                        completion(true, items)
                    }
                    catch _ as NSError {
                        fatalError("Couldn't load data from \(filePath)")
                    }
                }
            })
        }
    }
    
    func fetchProducts(completion: @escaping (Bool, Product?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(MockAPIClient.delay)) {
            let filePath = "Products"
            MockAPIClient.loadJsonDataFromFile(filePath, completion: { data in
                if let json = data {
                    do {
                        let items = try JSONDecoder().decode(Product.self, from: json)
                        completion(true, items)
                    }
                    catch _ as NSError {
                        fatalError("Couldn't load data from \(filePath)")
                    }
                }
            })
        }
    }
    
    func postOrderDetails(completion: @escaping (Bool, Order?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(MockAPIClient.delay)) {
            let filePath = "OrderDone"
            MockAPIClient.loadJsonDataFromFile(filePath, completion: { data in
                if let json = data {
                    do {
                        let items = try JSONDecoder().decode(Order.self, from: json)
                        completion(true, items)
                    }
                    catch _ as NSError {
                        fatalError("Couldn't load data from \(filePath)")
                    }
                }
            })
        }
    }
    
    private static func loadJsonDataFromFile(_ path: String, completion: (Data?) -> Void) {
        if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl, options: [])
                completion(data as Data)
            } catch (let error) {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
