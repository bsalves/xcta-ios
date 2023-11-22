//
//  URL+Extension.swift
//  Xcta
//
//  Created by Bruno Alves on 21/11/23.
//

import Foundation

extension URL {
    static func apiURL() -> URL {
        guard let url = URL(string: Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String ?? String())
        else {
            fatalError("URL value not found")
        }
        return url
    }
}
