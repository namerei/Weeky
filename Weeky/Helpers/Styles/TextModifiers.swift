//
//  TextModifiers.swift
//  Weeky
//
//  Created by Екатерина Кондратьева on 12.12.2023.
//

import SwiftUI

struct TextTitle: ViewModifier {
  func body(content:Content) -> some View{
    content.font(.system(size:20)).foregroundColor(Color.blue)
  }
}
