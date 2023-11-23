//
//  CartItem.swift
//  Xcta
//
//  Created by Bruno Alves on 22/11/23.
//

import Foundation

struct CartItem {
    
    enum QuantityError: Error {
        case onlyOne
    }
    
    var id = UUID()
    var productId: UUID
    var image: String
    var title: String
    var quantity: Int
    var price: String
    var size: Product.Size
    
    mutating func increase() {
        self.quantity += 1
    }
    
    mutating func decrease() throws {
        if quantity > 1 {
            self.quantity -= 1
            return
        }
        throw QuantityError.onlyOne
    }
}
