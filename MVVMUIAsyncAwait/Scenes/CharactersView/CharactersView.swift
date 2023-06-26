//
//  CharactersView.swift
//  MVVMUITest
//
//  Created by Zorin Dmitrii on 16.06.2023.
//

import SwiftUI

struct CharactersView: View {
    @StateObject var viewModel = CharacterViewModel()
    
    let colums = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: colums) {
                    ForEach(viewModel.model.results) { character in
                        NavigationLink(destination: DetailsView(character: character)) {
                            VStack {
                                Text(character.name)
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                    .minimumScaleFactor(0.3)
                                    .lineLimit(1)
                                
                                AsyncImage(url: URL(string: "\(character.image)")) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 150, height: 150)
                                
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
            }
            .alert(error: $viewModel.error)
            .navigationTitle("Characters")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbarBackground(Color.secondary, for: .navigationBar)
            //                .padding()
            .task { await viewModel.fetchData() }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Next") {
                        Task { await viewModel.fetch(from: viewModel.model.info.next) }
                    }
                    .disabled(viewModel.model.info.next == nil)
                }
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Prev") {
                        Task { await viewModel.fetch(from: viewModel.model.info.prev) }
                    }
                    .disabled(viewModel.model.info.prev == nil)
                }
            }
            .background(LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .bottomLeading,
                                       endPoint: .topLeading))
        }
    }
}


struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
