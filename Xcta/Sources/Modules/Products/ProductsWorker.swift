//
//  ProductsWorker.swift
//  Xcta
//
//  Created by Bruno Alves on 21/11/23.
//

import Foundation

final class ProductsWorker: ServiceWorker {
    func fetch() async throws -> Data {
        try await URLSession.shared.data(
            for: URLRequest(url: URL.apiURL())
        ).0
    }
}
