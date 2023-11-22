//
//  CartView.swift
//  Xcta
//
//  Created by Bruno Alves on 22/11/23.
//

import SwiftUI

struct CartView<ViewModel: CartViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var cart: Cart
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(cart.products, id: \.id) { item in
//                    CartItemView(
//                        imageURL: item.image,
//                        title: item.title,
//                        price: item.price,
//                        size: item.size
//                    )
//                    .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle(viewModel.viewData.viewTitle)
    }
}

#Preview {
    CartView(
        viewModel: CartViewModel(
            viewData: CartViewData()
        )
    )
}
