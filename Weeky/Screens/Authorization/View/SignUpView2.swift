//
//  SignUpView.swift
//  Weeky
//
//  Created by namerei on 10.04.24.
//
import SwiftUI

struct SignUpView : View {
    @EnvironmentObject var authViewModel: AuthorizationViewModel
    
    @Binding var index : Int
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    Spacer()
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
                }
                .padding(.top, 30)
                
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: "person.fill")
                            .foregroundColor(Color("Orange light"))
                        TextField("Имя пользователя", text: $authViewModel.email)
                    }
                    
                    Divider().background(Color.white.opacity(0.6))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                
                VStack {
                    HStack(spacing: 15) {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color("Orange light"))
                        SecureField("Пароль", text: $authViewModel.password)
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
            
            RegistrationButton(index: $index)
                .opacity(self.index == 1 ? 1 : 0)
        }
    }
}

//MARK: - Views
struct RegistrationButton: View {
    @State private var isShowingWeekPageView = false
    @Binding var index : Int
    @EnvironmentObject var authViewModel: AuthorizationViewModel
    
    var body: some View {
        Button(action: {
//            saveNewUser()
            withAnimation {
                index = 0
                authViewModel.eraseFields()
//                isShowingWeekPageView.toggle()
            }
        }, label: {
            Text("Зарегестрироваться")
                .foregroundColor(Color("Gray"))
                .fontWeight(.bold)
                .padding(.vertical)
                .padding(.horizontal, 50)
                .background(Color("Yellow xlight"))
                .clipShape(Capsule())
                .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                .offset(y: 25)
        })
        .fullScreenCover(isPresented: $isShowingWeekPageView, content: {
//            HomeView()
//                .transition(.move(edge: .leading))
            TestScreen()
        })
    }
    
    func saveNewUser() {
        print(authViewModel.email, authViewModel.password)
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
