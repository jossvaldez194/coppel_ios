//
//  ShowTvObject.swift
//  Coppel ios examen
//
//  Created by Josue Valdez Morales on 16/08/22.
//

import Foundation

struct ShowTvObject: Codable {
    let page: Int
    let results: [ResultsTv]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
