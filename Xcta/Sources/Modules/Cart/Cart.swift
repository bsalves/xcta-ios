//
//  Cart.swift
//  Xcta
//
//  Created by Bruno Alves on 22/11/23.
//

import Foundation

final class Cart {
    
    public static var shared = Cart()
    
    private var products = [Product]()
    
    private init() { }
    
    func add(product: Product) {
        products.append(product)
    }
    
    func remove(product: Product) {
        products.removeAll { $0.id == product.id }
    }
    
    func itemsAtCart() -> Int {
        products.count
    }
}
