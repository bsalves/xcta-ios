//
//  CartToolbarItemView.swift
//  Xcta
//
//  Created by Bruno Alves on 22/11/23.
//

import SwiftUI

struct CartToolbarItemView: View {
    
    @EnvironmentObject var cart: Cart
    
    var body: some View {
        NavigationLink(
            destination: {
                CartView(
                    viewModel: CartViewModel(
                        viewData: CartViewData()
                    )
                )
                .environmentObject(cart)
            },
            label: {
                HStack {
                    Image(systemName: "cart")
                    Text("\(cart.products.count)")
                }
            }
        )
    }
}

#Preview {
    CartToolbarItemView()
}
