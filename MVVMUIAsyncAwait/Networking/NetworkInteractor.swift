//
//  NetworkInteractor.swift
//  MVVMUITest
//
//  Created by Zorin Dmitrii on 22.06.2023.
//

import Foundation

class NetworkInteractor {
    
    @MainActor
    func fetchData(from url: String?, completion: @escaping (CharactersModel) -> Void) async {
        guard let url, let dataURL = URL(string: url) else {
            fatalError("Bad give URL! Sorry!")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: dataURL)
            let decodedResponse = try JSONDecoder().decode(CharactersModel.self, from: data)
                
            completion(decodedResponse)
        } catch {
            print(error.localizedDescription)
        }
    }
}
