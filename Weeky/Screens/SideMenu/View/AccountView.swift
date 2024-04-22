//
//  AccountView.swift
//  Weeky
//
//  Created by namerei on 21.04.24.
//

import SwiftUI

struct AccountView:View {
    @EnvironmentObject var viewModel : HomeViewModel
    @State private var isShowingSuccessView = false
    
    @State private var name = ""
    @State private var password = ""
    
    @Binding var isAuthorized : Bool
    @State private var error = "Пустые поля"
    
    var body: some View {
        VStack {
            ChangeUserData()
        }
    }
    
    //MARK: - Views
    func ChangeUserData()->some View {
        VStack {
            VStack{
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 80, height: 80)
                Text(viewModel.currentUser?.name ?? "")
                    .font(.largeTitle)
            }
            .frame(width: 400, height: 160)
            .background(Color("Blue dark"))
            
            VStack {
                HStack(spacing: 15) {
                    Image(systemName: "eye.slash.fill")
                        .foregroundColor(Color("Blue light"))
                    SecureField("Изменить пароль", text: $password)
                }
                
                Divider()
                    .background(Color.white.opacity(0.6))
            } .padding(.horizontal)
                .padding(.top, 50)
            
            AcceptButton()
            
            Button(action: {
                viewModel.currentUser = nil
                withAnimation {
                    isAuthorized = false
                }
            }) {
                Text("Выйти из аккаунта")
                    .foregroundColor(.red)
            }
            .padding()
            Spacer()
        }
    }
    
    func AcceptButton()->some View {
        VStack {
            if !isShowingSuccessView {
                Button(action: {
                    if name != "" || password != "" {
                        //MARK: - update Data
                        viewModel.updatePassword( password)
                        error = ""
                        withAnimation {
                            isShowingSuccessView = true
                            name = ""
                            password = ""
                        }
                    }
                    isShowingSuccessView = true
                }, label: {
                    Text("Внести изменения")
                        .foregroundColor(.gray)
                        .fontWeight(.medium)
                        .padding()
                        .clipShape(Capsule())
                        .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                                        .offset(y: 25)
                })
            } else {
                SuccessView(text: "Данные изменены", error: error)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                isShowingSuccessView = false
                            }
                        }
                    }
            }
        }
    }
}

struct Previews_AccountView: PreviewProvider {
    
    static var previews: some View {
        @State var show = true
        
        AccountView(isAuthorized: $show)
    }
}
