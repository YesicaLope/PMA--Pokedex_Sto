//
//  PokemonManager.swift
//  Pokedex
//
//  Created by MAC08 on 14/07/22.
//

import Foundation

// Recuperar los datos en el modelo vista
class PokemonManager {

     // Devuelve una serie de pokemones
    func getPokemon() -> [Pokemon] {
        let data: PokemonPage = Bundle.main.decode(file:"pokemon.json")
        let pokemon: [Pokemon] = data.results
        
        return pokemon
    }
    
    // Obtener los datos y si sale error, ver el modelo
    func getDetailedPokemon(id: Int, _ completion:@escaping (DetailPokemon) -> ()) {
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon/\(id)/", model: DetailPokemon.self) { data in
            completion(data)
            print(data)
            
        } failure: { error in
            print(error)
        }
    }
}