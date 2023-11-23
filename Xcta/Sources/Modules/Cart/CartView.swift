//
//  CartView.swift
//  Xcta
//
//  Created by Bruno Alves on 22/11/23.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var viewModel: CartViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach($viewModel.products, id: \.id) { item in
                    CartItemView(
                        item: item,
                        removeItem: { sku in
                            viewModel.removeProduct(sku)
                        }
                    )
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle(viewModel.viewData.viewTitle)
        .toolbar {
            ToolbarItem {
                Text("R$ \(viewModel.amountTotal)")
            }
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
                    quantity: 1,
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
