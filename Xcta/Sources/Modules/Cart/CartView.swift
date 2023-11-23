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
        ZStack {
            if viewModel.products.isEmpty {
                emptyStateView
            } else {
                cartContent
            }
        }
        .navigationTitle(viewModel.viewData.viewTitle)
        .toolbar {
            ToolbarItem {
                Text("R$ \(viewModel.amountTotal)")
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack {
            Image(systemName: "cart")
                .resizable()
                .frame(width: 30, height: 30)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.gray)
            Text("Carrinho vazio")
        }
    }
    
    private var cartContent: some View {
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
    }
}

#Preview {
    NavigationView {
        CartView()
        .environmentObject(
            CartViewModel(
                products: [
                    CartItem(
                        productId: UUID(),
                        image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912",
                        title: "Calça",
                        quantity: 1,
                        price: "R$ 1,99",
                        size: Product.Size(
                            title: "P",
                            sku: "00_P"
                        )
                    )
                ]
            )
        )
        .navigationBarTitleDisplayMode(.inline)
    }
}
