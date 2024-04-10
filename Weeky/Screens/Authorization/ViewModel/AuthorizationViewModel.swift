//
//  ContentViewViewModel.swift
//  Weeky
//
//  Created by Екатерина Кондратьева on 11.01.2024.
//

import Foundation
class AuthorizationViewModel: ObservableObject
{
  @Published var email = ""
  @Published var pass = ""
  @Published var repass = ""
  @Published var errorMessage = ""

  init() {}
  
  func login() {
    guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
          !pass.trimmingCharacters(in: .whitespaces).isEmpty  else {
      errorMessage = "Пожалуйста, заполните все поля"
      
      return
    }
  }
  func validate() {  }

}
