//
//  SpokenLanguage.swift
//  Coppel ios examen
//
//  Created by Josue Valdez Morales on 17/08/22.
//

import UIKit

struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
