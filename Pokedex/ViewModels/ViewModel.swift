//
//  ViewModel.swift
//  Pokedex
//
//  Created by MAC08 on 14/07/22.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    private let pokemonManager = PokemonManager()
    
    @Published var pokemonList = [Pokemon]()
    @Published var pokemonDetails: DetailPokemon?
    @Published var searchText = ""
    
    // Se usa con searchText para filtrar los resultados del Pókemon.
    var filteredPokemon: [Pokemon] {
                return searchText == "" ? pokemonList : pokemonList.filter { $0.name.contains(searchText.lowercased()) }
            }
    
    init() {
        self.pokemonList = pokemonManager.getPokemon()
        // Sólo la primera vez pàra ver en consola, lo activamos 1 vez.
        //  print(self.pokemonList)
    }
    
    
    // Obtener el índice de un pokemon (índice + 1 = id de pokemon).
    func getPokemonIndex(pokemon: Pokemon) -> Int {
        if let index = self.pokemonList.firstIndex(of: pokemon) {
            return index + 1
        }
        return 0
    }
    
    // Obtener detalles específicos para un pokemon.
    func getDetails(pokemon: Pokemon) {
        let id = getPokemonIndex(pokemon: pokemon)
        
        self.pokemonDetails = DetailPokemon(id: 0, height: 0, weight: 0)
        
        pokemonManager.getDetailedPokemon(id: id) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
        }
    }
    
    // Formatea la Altura o el Peso de un pokemon dado.
    func formatHW(value: Int) -> String {
        let dValue = Double(value)
        let string = String(format: "%.2f", dValue / 10)
        
        return string
    }
}