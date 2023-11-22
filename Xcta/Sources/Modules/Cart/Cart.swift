//
//  Cart.swift
//  Xcta
//
//  Created by Bruno Alves on 22/11/23.
//

import Foundation

final class Cart: ObservableObject {
    
    @Published var products = [CartItem]()
    
    func add(product: CartItem) {
        products.append(product)
    }
    
    func remove(product: CartItem) {
        products.removeAll { $0.id == product.id }
    }
}
