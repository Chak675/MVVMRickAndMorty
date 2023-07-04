//
//  CharactersViewErrorAlert.swift
//  MVVMUITest
//
//  Created by Zorin Dmitrii on 22.06.2023.
//

import SwiftUI

extension View {
    func alert<ErrorMessage: Error>(error: Binding<ErrorMessage?>, title: LocalizedStringKey? = nil) -> some View {
        modifier(
            ItemErrorAlertModifier(
                error: error,
                title: title
            )
        )
    }
}

struct ItemErrorAlertModifier<ErrorMessage: Error>: ViewModifier {
    
    @Binding var error: ErrorMessage?
    
    let title: LocalizedStringKey?
    
    @Binding private var isPresented: Bool
    
    init(error: Binding<ErrorMessage?>, title: LocalizedStringKey?) {
        self._error = error
        self.title = title
        
        self._isPresented = Binding<Bool>(
            get: {
                error.wrappedValue != nil
            },
            set: {
                if !$0 {
                    error.wrappedValue = nil
                }
            }
        )
    }
    
    
    func body(content: Content) -> some View {
        content
        .alert(
            title ?? "Error",
            isPresented: $isPresented,
            actions: { Button("ОК", action: {}) },
            message: { Text(error?.localizedDescription ?? "Error message") }
            
        )
    }
}
