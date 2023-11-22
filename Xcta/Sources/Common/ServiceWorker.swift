//
//  ServiceWorker.swift
//  Xcta
//
//  Created by Bruno Alves on 21/11/23.
//

import Foundation

protocol ServiceWorker {
    func fetch() async throws -> Data
}
