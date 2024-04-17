
import SwiftUI

struct AuthorizationView: View {
    @StateObject var authViewModel = AuthorizationViewModel()
    
    @State private var isShowingDetailsView = false
    
    @State var index = 0
    @Binding var isAuthorized: Bool
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                Text("Weeky")
                    .foregroundColor(Color("Blue light"))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                ZStack {
                    SignUpView(index: self.$index)
                        .zIndex(Double(self.index))
                    Login(index: $index, isAuthorized: $isAuthorized)
                }
                .environmentObject(authViewModel)
                .padding(.vertical)
            }
        }
        .background(Color("Blue xlight").edgesIgnoringSafeArea(.all))
    }
    
}
//}


//#Preview {
//    AuthorizationView()
//}


//MARK: logic
/*
 1) registration - save user - isAuthorized
 2) login: check if user saved - isAuthorized
 3) if user logged fetch all tasks, show etc
 */
