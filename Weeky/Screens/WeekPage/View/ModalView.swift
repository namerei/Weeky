//
//  ModalView.swift
//  Weeky
//
//  Created by Nikita Evdokimov on 12.04.24.
//

import SwiftUI

struct ModalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            // Задний фон с размытием
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            // Модальное представление
            VStack {
                Text("Modal Content")
                    .padding()
                
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(20)
            .padding()
        }
        .blur(radius: 3) // Применяем эффект размытия
    }
}
