//
//  XctaApp.swift
//  Xcta
//
//  Created by Bruno Alves on 21/11/23.
//

import SwiftUI

@main
struct XctaApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ProductsView(
                    viewModel: ProductsViewModel(
                        service: ProductsWorker()
                    )
                )
                .toolbar { CartToolbarItemView() }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
