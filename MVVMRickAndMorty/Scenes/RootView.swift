//
//  RootView.swift
//  MVVMUIAsyncAwait
//
//  Created by Zorin Dmitrii on 14.06.2023.
//

import SwiftUI

struct RootView: View {
    
    var body: some View {
        NavigationStack {
            CharactersView()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
