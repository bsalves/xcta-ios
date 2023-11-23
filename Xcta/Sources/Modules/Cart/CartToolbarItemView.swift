//
//  CartToolbarItemView.swift
//  Xcta
//
//  Created by Bruno Alves on 22/11/23.
//

import SwiftUI

struct CartToolbarItemView: View {
    
    @EnvironmentObject var cartViewModel: CartViewModel
    
    var body: some View {
        NavigationLink(
            destination: {
                CartView()
                .environmentObject(cartViewModel)
            },
            label: {
                HStack {
                    Image(systemName: "cart")
                    Text("\(cartViewModel.numberOfItems)")
                }
            }
        )
    }
}

#Preview {
    CartToolbarItemView()
}
