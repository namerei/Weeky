//
//  SignUpView2.swift
//  Weeky
//
//  Created by Nikita Evdokimov on 10.04.24.
//
import SwiftUI

struct SignUpView : View {
    @StateObject var viewModel = AuthorizationViewModel()
    @Binding var index : Int
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    Spacer()
//                    Spacer()
                    VStack(spacing: 10) {
                        Text("Регистрация")
                            .foregroundColor(self.index == 1 ? .white : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        Capsule()
                            .fill(self.index == 1 ? Color("Yellow light") : Color.clear)
                            .frame(width: 100, height: 5)
                    }
//                    Spacer()
                }
                .padding(.top, 30)
                
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: "person.fill")
                            .foregroundColor(Color("Orange light"))
                        TextField("Имя пользователя", text: $viewModel.email)
                    }
                    
                    Divider().background(Color.white.opacity(0.6))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                
                VStack {
                    HStack(spacing: 15) {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color("Orange light"))
                        SecureField("Пароль", text: $viewModel.pass)
                    }
                    
                    Divider()
                        .background(Color.white.opacity(0.6))
                } .padding(.horizontal)
                    .padding(.top, 50)
                
            }   .padding()
                .padding(.bottom, 70)
                .background(Color("Blue dark"))
                .clipShape(CShape1())
                .contentShape(CShape1())
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
                .onTapGesture {
                    self.index = 1
                }
                .cornerRadius(35)
                .padding(.horizontal, 20)
            
            
            NavigationLink("Зарегестрироваться", destination: WeekPageView())
                .foregroundColor(Color("Gray"))
                .fontWeight(.bold)
                .padding(.vertical)
                .padding(.horizontal, 50)
                .background(Color("Yellow xlight"))
                .clipShape(Capsule())
                .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
            
                .offset(y: 25)
                .opacity(self.index == 1 ? 1 : 0)
        }
    }
}


struct CShape1: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 100))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
        }
    }

}
