//
//  CartViewModel.swift
//  Xcta
//
//  Created by Bruno Alves on 22/11/23.
//

import Foundation

final class CartViewModel: ObservableObject {
    
    @Published var products: [CartItem] {
        didSet { calcNumberOfItems() }
    }
    @Published var viewData: CartViewData
    @Published var numberOfItems: Int = 0
    
    init(products: [CartItem] = [CartItem](), viewData: CartViewData = CartViewData()) {
        self.products = products
        self.viewData = viewData
    }
    
    func addProduct(_ product: Product, size: Product.Size) {
        guard let productToBeIncreased = products.first(where: { item in
            item.size.sku == size.sku
        })?.size.sku else {
            products.append(
                CartItem(
                    productId: product.id,
                    image: product.image,
                    title: product.title,
                    quantity: 1, 
                    price: product.promotionalValue ?? product.value,
                    size: size
                )
            )
            return
        }
        guard let productIndex = products.firstIndex(where: { item in
            item.size.sku == productToBeIncreased
        }) else { return }
        products[productIndex].quantity += 1
    }
    
    func removeProduct(_ sku: Sku) {
        products.removeAll { $0.size.sku == sku }
    }
    
    // MARK: - Private properties
    
    private func calcNumberOfItems() {
        var sum = 0
        products.forEach {
            sum += $0.quantity
        }
        numberOfItems = sum
    }
}
