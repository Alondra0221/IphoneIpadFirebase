//
//  NavBar.swift
//  IphoneIpadFirebase
//
//  Created by Alondra García Morales on 01/11/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct NavBar: View {
    
    var device = UIDevice.current.userInterfaceIdiom
    @Binding var index : String
    @Binding var menu : Bool
    @EnvironmentObject var loginShow : FirebaseViewModel
    
    var body: some View {
        HStack{
            Text("My Games")
                .font(.title)
                .bold()
                .foregroundStyle(.white)
                .font(.system(size: device == .phone ? 25 : 35))
            Spacer()
            if device == .pad {
                ///Menu para ipad
                HStack(spacing: 25){
                    ButtonView(index: $index, menu: $menu, title: "Playstation")
                    ButtonView(index: $index, menu: $menu, title: "Xbox")
                    ButtonView(index: $index, menu: $menu, title: "Nintendo")
                    ButtonView(index: $index, menu: $menu, title: "+")
                    Button(action: {
                        try! Auth.auth().signOut()
                        UserDefaults.standard.removeObject(forKey: "sesion")
                        loginShow.show = false
                    }){
                        Text("Exit")
                            .font(.title)
                            .frame(width: 150)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 5)
                    }.background(
                        Capsule().stroke(Color.white)
                    )
                }
            }else {
                
                /// Menu para iphone
                
                Button(action: {
                    index = "Add"
                }){
                    Image(systemName: "plus")
                        .font(.system(size: 26))
                        .foregroundStyle(.white)
                }
                
                Button(action: {
                    withAnimation{
                        menu.toggle()
                    }
                }){
                    Image(systemName: "line.3.horizontal")
                        .font(.system(size: 26))
                        .foregroundStyle(.white)
                }
            }
        }.padding(.top,50)
         .padding()
         .background(Color("skyblue"))
    }
}


