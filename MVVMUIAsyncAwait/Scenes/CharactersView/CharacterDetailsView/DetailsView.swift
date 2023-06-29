//
//  DetailsView.swift
//  MVVMUITest
//
//  Created by Zorin Dmitrii on 16.06.2023.
//

import SwiftUI

struct DetailsView: View {
    
    let character: Results
    
    var body: some View {
        ZStack {
            NavigationStack {
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 300, height: 300)
                .cornerRadius(200)
                
                ZStack {
                    VStack {
                        List {
                            Section {
                                Text("Status: ") + Text( "\(character.status.description)")
                                    .font(.body)
                                    .foregroundColor(
                                        character.status == .alive
                                        ? .green : character.status == .dead
                                        ? .red : .gray
                                    )
                                Text("Location: \(character.location.name)")
                            }
                            .cornerRadius(10)
                            
                            Section() {
                                Text("Gender: \(character.gender)")
                                Text("ID: \(character.id)")
                                Text("Species: \(character.species)")
                                
                                if !character.type.isEmpty {
                                    Text("Type: \(character.type)")
                                }
                            }
                        }
                        .cornerRadius(50)
                        .padding()
                    }
                }
                .background(.gray)
                .cornerRadius(50)
                .edgesIgnoringSafeArea(.bottom)
            }
            .navigationTitle("\(character.name)")
            .navigationBarTitleDisplayMode(.inline)
            //изменить название кнопки на "Back" через tool bar item?.
        }
        .background(LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .center,
                                   endPoint: .topLeading))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(
            character: .init(
                id: 0,
                name: "",
                status: .unknown,
                species: "",
                type: "",
                gender: "",
                image: "",
                location: .init(name: "")
            )
        )
    }
}
