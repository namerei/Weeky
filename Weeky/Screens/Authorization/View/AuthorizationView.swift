
import SwiftUI

struct AuthorizationView: View {
    @EnvironmentObject var authViewModel : AuthorizationViewModel
    
    @State private var isShowingDetailsView = false
    
    @State var index = 0
    @Binding var isAuthorized: Bool
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                Text("Weeky")
                    .foregroundColor(Colors.blueDarkReverse)
                    .font(Fonts.mainTitle)
                    .fontWeight(.bold)
                ZStack {
                    SignUpView(index: self.$index)
                        .zIndex(Double(self.index))
                    Login(index: $index, isAuthorized: $isAuthorized)
                }
                .environmentObject(authViewModel)
//                .padding(.vertical)
            }
            .offset(y: 50)
        }
        .background(Color("Background").edgesIgnoringSafeArea(.all))
        
//        .font(Font.custom("PT Sans", size: 16))
    }
}

