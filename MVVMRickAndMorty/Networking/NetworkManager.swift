//
//  NetworkManager.swift
//  MVVMUITest
//
//  Created by Zorin Dmitrii on 16.06.2023.
//

import Foundation

class NetworkManager {
    
    enum NetworkError: String, Error {
        case invalidURL = "Invalid URL address"
    }
    
    @MainActor
    func fetchData(from url: String?, completion: @escaping (Result<CharactersModel, Error>) -> Void) async {
        guard let url, let dataURL = URL(string: url) else {
            return completion(.failure(NetworkError.invalidURL))
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: dataURL)
            let decodedResponse = try JSONDecoder().decode(CharactersModel.self, from: data)
                
            completion(.success(decodedResponse))
        } catch let error {
            completion(.failure(error))
        }
    }
}
