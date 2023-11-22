//
//  CartItem.swift
//  Xcta
//
//  Created by Bruno Alves on 22/11/23.
//

import Foundation

struct CartItem {
    var id = UUID()
    var productId: UUID
    var image: String
    var title: String
    var quantity: Int = 1
    var price: String
    var size: Product.Size
}
