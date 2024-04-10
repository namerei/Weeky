
import SwiftUI

struct AuthorizationView: View {
  @State private var isShowingDetailsView = false
  @State var index = 0
  
 
  var body: some View {
    NavigationView {
      GeometryReader { _ in
        
        VStack {
            Text("Weeky")
                .foregroundColor(Color("Blue light"))
                .font(.largeTitle)
                .fontWeight(.bold)
          /*
            Image("logo")
            .resizable()
            .frame(width: 70, height: 70)
            */
          ZStack {
            SignUpView(index: self.$index)
              .zIndex(Double(self.index))
            Login(index: self.$index)
          }
          
//            SocialAutorizationsView()
        }
        .padding(.vertical)
      }
      .background(Color("Blue xlight").edgesIgnoringSafeArea(.all))
    }
  }
}


#Preview {
    AuthorizationView()
}
