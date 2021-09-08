//
//  PokemonAPIModel.swift
//  PokeAPISwiftUI
//
//  Created by Rin on 2021/09/08.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let sprites: Images
}

struct Images: Codable {
    let frontImage: String
    
    enum CodingKeys: String, CodingKey {
        case frontImage = "front_default"
    }
}
