//
//  ContentView.swift
//  PokeAPISwiftUI
//
//  Created by Rin on 2021/09/07.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var pokemonAPIVM = PokemonAPIViewModel()
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: stringToData(string: pokemonAPIVM.data?.sprites.frontImage))!)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)

            Text(pokemonAPIVM.data!.name)
                .padding(.vertical, 100)
            
            Button("search") {
                pokemonAPIVM.id = Int(text) ?? 1
            }
            .frame(width: 100, height: 20, alignment: .center)
            .font(.system(size: 20))
            
            TextField("", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 100, height: 30, alignment: .center)
                .padding(.top, 50)
                .multilineTextAlignment(.trailing)
        }
        .onChange(of: pokemonAPIVM.id) { _ in
            pokemonAPIVM.getPokemonName(id: pokemonAPIVM.id) { pokemon in
                DispatchQueue.main.async {
                    self.pokemonAPIVM.data = pokemon
                }
            }
        }
    }
    
    private func stringToData(string: String?) -> Data {
        guard let string = string else {
            return Data()
        }
        let url = URL(string: string)
        let data = try? Data(contentsOf: url!)
        return data!
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
