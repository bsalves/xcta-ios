//
//  CartViewModel.swift
//  Xcta
//
//  Created by Bruno Alves on 22/11/23.
//

import Foundation

final class CartViewModel: ObservableObject {
    
    @Published var products: [CartItem]
    
    init(products: [CartItem] = [CartItem]()) {
        self.products = products
    }
    
    func addProduct(_ product: Product, size: Product.Size) {
        products.append(
            CartItem(
                productId: product.id,
                image: product.image,
                title: product.title,
                price: product.promotionalValue ?? product.value,
                size: size
            )
        )
    }
    
    func removeProduct(_ product: CartItem) {
//        products.removeAll { $0.id == product.id }
    }
}
