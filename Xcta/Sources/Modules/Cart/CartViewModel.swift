//
//  CartViewModel.swift
//  Xcta
//
//  Created by Bruno Alves on 22/11/23.
//

import Foundation

protocol CartViewModelProtocol: ObservableObject {
    var viewData: CartViewData { get set }
}

final class CartViewModel: CartViewModelProtocol {
    
    // MARK: - Publishers
    
    @Published var viewData: CartViewData
    
    // MARK: - Initializer
    
    init(viewData: CartViewData) {
        self.viewData = viewData
    }
}
