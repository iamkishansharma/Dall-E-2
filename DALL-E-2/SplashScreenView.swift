//
//  SplashScreenView.swift
//  DALL-E-2
//
//  Created by Kishan Kr Sharma on 1/29/23.
//
import SwiftUI

struct SplashScreenView: View {
    @State var isActive: Bool = false
    @State private var size = 0.7
    @State private var opacity = 0.4
    
    var body: some View {
        if isActive {
            // load main screen after isActive set to true
            HomeView()
        }else{
            ZStack{
                LinearGradient(colors: [.black, .black], startPoint: .zero, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center){
                    Spacer()
                    Image("dalle2")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.width/1.1)
                    Spacer()
                    Text("Build with ❤️ by")
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .purple, radius: 10)
                    
                    Text("Kishan Kr Sharma")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .purple, radius: 10)
                }
                .padding()
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeInOut(duration: 1.4)){
                        self.size = 1.0
                        self.opacity = 1.0
                    }
                }
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                    withAnimation{
                        self.isActive = true
                    }
                }
            }
        }
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
