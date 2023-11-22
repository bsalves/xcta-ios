//
//  CartView.swift
//  Xcta
//
//  Created by Bruno Alves on 22/11/23.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var cart: CartViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(cart.products, id: \.id) { item in
                    CartItemView(
                        item: .constant(
                            CartItem(
                                productId: item.id,
                                image: item.image,
                                title: item.title,
                                price: item.price,
                                size: item.size
                            )
                        )  
                    )
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    CartView()
    .environmentObject(
        CartViewModel(
            products: [
                CartItem(
                    productId: UUID(),
                    image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912",
                    title: "Calça",
                    price: "$ 1,99",
                    size: Product.Size(
                        title: "P", 
                        sku: "00_P"
                    )
                )
            ]
        )
    )
}
