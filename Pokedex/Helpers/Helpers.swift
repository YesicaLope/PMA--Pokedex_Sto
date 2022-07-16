//
//  Helpers.swift
//  Pokedex
//
//  Created by MAC08 on 14/07/22.
//
//_____Para poder simplificar la vioda de nuestra APP_____

import Foundation

extension Bundle {

//Obtiene los códigos json
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("No se pudo encontrar \(file) en paquete.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("No se pudo cargar \(file) desde el paquete.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("No se pudo decodificar \(file) el paquete.")
        }
        
        return loadedData
    }
    
//Obtiene los datos, luego lo decodifica
    func fetchData<T: Decodable>(url: String, model: T.Type, completion:@escaping(T) -> (), failure:@escaping(Error) -> ()) {
            guard let url = URL(string: url) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    // Si hay un error, devuelve el error.
                    if let error = error { failure(error) }
                    return }
                
                do {
                    let serverData = try JSONDecoder().decode(T.self, from: data)
                    // Si hay un error, devuelve el error.
                    completion((serverData))
                } catch {
                    // Si hay un error, devuelve el error.
                    failure(error)
                }
            }.resume()
    }
}