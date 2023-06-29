//
//  CharactersViewModel.swift
//  MVVMUITest
//
//  Created by Zorin Dmitrii on 16.06.2023.
//

import Foundation

class CharacterViewModel: ObservableObject {
    
    @Published var model: CharactersModel = .default
    @Published var error: Error?
    
    private let networkManager = NetworkManager()
    private let networkInteractor = NetworkInteractor()
    
    func fetch(from url: String? = "https://rickandmortyapi.com/api/character") async {
        await networkManager.fetchData(from: url) { [weak self] result in
            switch result {
            case .success(let model): self?.model = model
            case .failure(let error): self?.error = error
            }
        }
    }
}
