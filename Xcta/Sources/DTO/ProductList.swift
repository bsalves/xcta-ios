//
//  Product.swift
//  Xcta
//
//  Created by Bruno Alves on 21/11/23.
//

import Foundation

struct ProductList: Decodable {
    
    let products: [Product]
    
    struct Product: Decodable {
        let name, style, codeColor, colorSlug: String
        let color: String
        let onSale: Bool
        let actualPrice: String?
        let regularPrice, discountPercentage, installments: String
        let image: String
        let sizes: [Size]
        
        struct Size: Decodable {
            let available: Bool
            let size, sku: String
        }

        enum CodingKeys: String, CodingKey {
            case name, style
            case codeColor = "code_color"
            case colorSlug = "color_slug"
            case color
            case onSale = "on_sale"
            case regularPrice = "regular_price"
            case actualPrice = "actual_price"
            case discountPercentage = "discount_percentage"
            case installments, image, sizes
        }
    }
}
