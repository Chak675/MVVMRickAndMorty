//
//  CharactersModel.swift
//  MVVMUITest
//
//  Created by Zorin Dmitrii on 16.06.2023.
//

import Foundation

struct CharactersModel: Codable {
    static let `default` = CharactersModel(info: .init(pages: 0, next: nil, prev: nil), results: [])
    
    let info: Info
    let results: [Results]
}

struct Info: Codable {
    let pages: Int
    let next: String?
    let prev: String?
   
}

struct Results: Codable, Identifiable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: String
    let image: String
    let location: Location
}

struct Location: Codable {
    let name: String
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)
        
        if let status = Status(rawValue: stringValue) {
            self = status
        } else {
            self = .unknown
        }
    }
    
    var description: String {
        switch self {
        case .alive, .dead: return self.rawValue
        case .unknown: return self.rawValue.capitalized
        }
    }
}
