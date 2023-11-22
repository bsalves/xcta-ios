//
//  CartToolbarItemView.swift
//  Xcta
//
//  Created by Bruno Alves on 22/11/23.
//

import SwiftUI

struct CartToolbarItemView: View {
    var body: some View {
        NavigationLink(
            destination: { CartView() },
            label: {
                HStack {
                    Image(systemName: "cart")
                    Text("\(Cart.shared.itemsAtCart())")
                }
            }
        )
    }
}

#Preview {
    CartToolbarItemView()
}
