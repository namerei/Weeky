//
//  ViewExtensions.swift
//  Weeky
//
//  Created by namerei on 10.04.24.
//

import SwiftUI

extension View{
//    func hLeading()-> some View{
//        self
//            .frame(maxWidth: .infinity, alignment: .leading)
//    }
//    func hTrailing()-> some View{
//        self
//            .frame(maxWidth: .infinity, alignment: .trailing)
//    }
//    func hCenter()-> some View{
//        self
//            .frame(maxWidth: .infinity, alignment: .center)
//    }
    
    //Safe Area
    func getSafeArea()->UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        
        return safeArea
    }
    
    func textTitle() -> some View {
      self.modifier(TextTitle())
    }

    
    // MARK: Vertical Center
    func vCenter() -> some View {
        self
            .frame(maxHeight: . infinity, alignment: .center)
    }
    
    // MARK: Vertical Top
    func vTop() -> some View {
        self
            .frame(maxHeight: . infinity, alignment: .top)
    }
    // MARK: Vertical Bottom
    func vBottom() -> some View {
        self
            .frame(maxHeight: . infinity, alignment: .bottom)
    }
    
    // MARK: Horizontal Center
    func hCenter() -> some View {
        self
            .frame(maxWidth: . infinity, alignment: .center)
    }
    
    // MARK: Horizontal Leading
    func hLeading() -> some View {
        self
            .frame(maxWidth: . infinity, alignment: .leading)
    }
    
    // MARK: Horizontal Trailing
    func hTrailing() -> some View {
        self
            .frame(maxWidth: . infinity, alignment: .trailing)
    }

    // MARK: Max Width
    func maxWidth() -> some View {
        self
            .frame(maxWidth: . infinity)
    }

    // MARK: Max Height
    func maxHeight() -> some View {
        self
            .frame(maxHeight: . infinity)
    }
}



