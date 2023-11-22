//
//  Product.swift
//  Xcta
//
//  Created by Bruno Alves on 21/11/23.
//

import Foundation

struct Product {
    var id = UUID()
    var image: String
    var title: String
    var value: String
    var promotionalValue: String?
    var availableSizes: [Size]
    var sale: Bool
    
    struct Size {
        var title: String
        var sku: String
    }
}
