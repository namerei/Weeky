//
//  LoginView.swift
//  Weeky
//
//  Created by namerei on 10.04.24.
//

import SwiftUI

struct Login : View {
    @EnvironmentObject var viewModel : AuthorizationViewModel
    @Binding var index : Int
    @Binding var isAuthorized: Bool
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    VStack(spacing: 10) {
                        Text("Вход")
                            .foregroundColor(self.index == 0 ? .white : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        Capsule()
                            .fill(self.index == 0 ? Color("Yellow light") : Color.clear)
                            .frame(width: 100, height: 5)
                    }
                    Spacer()
                }
                .padding(.top, 30)
                
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: "person.fill")
                            .foregroundColor(Color("Orange light"))
                        TextField("Имя пользователя", text: $viewModel.name)
                    }
                    
                    Divider().background(Color.white.opacity(0.8))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                
                VStack {
                    HStack(spacing: 15) {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color("Orange light"))
                        SecureField("Пароль", text: $viewModel.password)
                    }
                    
                    Divider()
                        .background(Color.white.opacity(0.8))
                }
                .padding(.horizontal)
                .padding(.top, 50)
            }
            .padding()
            .padding(.bottom, 70)
            .background(Color("Blue light"))
            .clipShape(CShape())
            .contentShape(CShape())
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
            .onTapGesture {
                self.index = 0
            }
            .cornerRadius(35)
            .padding(.horizontal, 20)
            
            LoginButton(isAuthorized: $isAuthorized)
                .opacity(self.index == 1 ? 0 : 1)
        }
    }
}

struct LoginButton: View {
    @Binding var isAuthorized: Bool
    @EnvironmentObject var authViewModel: AuthorizationViewModel
    
    var body: some View {
        Button(action: {
            
            //MARK: - login logic
            
            authViewModel.login { success in
                if success {
                    print("\(authViewModel.user?.name) logged in successfully")
                    withAnimation {
                        isAuthorized.toggle()
                    }
                }
            }
        }, label: {
            Text("Вход")
                .foregroundColor(Color("Gray"))
                .fontWeight(.bold)
                .padding(.vertical)
                .padding(.horizontal, 50)
                .background(Color("Yellow xlight"))
                .clipShape(Capsule())
                .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                .offset(y: 25)
        })
    }
    
    func saveNewUser() {
//        print(authViewModel.email, authViewModel.password)
    }
}


struct CShape: Shape {
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            path.move(to: CGPoint(x: rect.width, y: 110))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: 0))
        }
    }
}
