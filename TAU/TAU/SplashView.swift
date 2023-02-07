//
//  SplashView.swift
//  TAU
//
//  Created by Ganesh Raju Galla on 06/02/23.
//

import SwiftUI

struct SplashView: View {
    @State var isActive:Bool
    var body: some View {
        ZStack{
            if isActive{
                ContentView()
            }else{
                ZStack{
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(Color("AccentColor"))
                    
                    Image("appstore")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:110,height: 110)
                        .cornerRadius(20)
                    
                }
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                withAnimation(.spring()){
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(isActive: false)
    }
}
