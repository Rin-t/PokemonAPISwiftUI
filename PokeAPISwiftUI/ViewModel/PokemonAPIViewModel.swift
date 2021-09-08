//
//  PokemonAPIViewModel.swift
//  PokeAPISwiftUI
//
//  Created by Rin on 2021/09/08.
//

import Foundation

class PokemonAPIViewModel: ObservableObject {
    @Published var id: Int = 1
    @Published var data: Pokemon?
    
    init() {
        getPokemonName(id: id) { pokemon in
            self.data = pokemon
        }
    }
    
    func getPokemonName(id: Int, complitionHandler: @escaping (Pokemon) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("error")
            }

            guard let data = data,
                  response != nil else {
                print("data or response are nil")
                return
            }

            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                complitionHandler(pokemon)
            } catch {
                complitionHandler(Pokemon(name: "", sprites: Images(frontImage: "")))
            }
        }
        task.resume()
    }
}
