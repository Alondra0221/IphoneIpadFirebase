//
//  Login.swift
//  IphoneIpadFirebase
//
//  Created by Alondra García Morales on 02/11/23.
//

import SwiftUI

struct Login: View {
    
    @State private var email = ""
    @State private var pass = ""
    @StateObject var login = FirebaseViewModel()
    @EnvironmentObject var loginShow : FirebaseViewModel
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea(.all)
            VStack{
                Text("My Games")
                    .font(.largeTitle)
                    .foregroundStyle(LinearGradient (gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                    .fontWeight(.black)
                    .padding(.bottom, 50)
                ZStack {
                    TextField("", text: $email)
                      .padding(.horizontal, 10)
                      .keyboardType(.emailAddress)
                      .autocorrectionDisabled(true)
                      .textInputAutocapitalization(.none)
                      .frame(width: device == .pad ? 400 : nil, height: 42)
                      .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                            .stroke(Color.gray, lineWidth: 1)
                      )
                    HStack {                    // HStack for the text
                      Text("Email")
                        .font(.headline)
                        .fontWeight(.thin)      // making the text small
                        .foregroundColor(Color.gray)    // and gray
                        .multilineTextAlignment(.leading)
                        .padding(4)
                        .background(.white)     // adding some white background
                      Spacer()                  // pushing the text to the left
                    }
                    .padding(.leading, device == .phone ?  8 : 200)
                    .offset(CGSize(width: 0, height: -20))  // pushign the text up to overlay the border of the input field
                  }.padding(4)
                    .padding(.bottom, 10)
                
                ZStack {
                    SecureField("", text: $pass)
                      .padding(.horizontal, 10)
                      .frame(width: device == .pad ? 400 : nil, height: 42)
                      .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                            .stroke(Color.gray, lineWidth: 1)
                      )
                    HStack {                    // HStack for the text
                      Text("Password")
                        .font(.headline)
                        .fontWeight(.thin)      // making the text small
                        .foregroundColor(Color.gray)    // and gray
                        .multilineTextAlignment(.leading)
                        .padding(4)
                        .background(.white)     // adding some white background
                      Spacer()                  // pushing the text to the left
                    }
                    .padding(.leading, device == .phone ?  8 : 200)
                    .offset(CGSize(width: 0, height: -20))  // pushign the text up to overlay the border of the input field
                  }.padding(4)
                
                
                Button(action:{
                    login.login(email: email, pass: pass){ (done) in
                        if done{
                            UserDefaults.standard.set(true, forKey: "sesion")
                            loginShow.show.toggle()
                        }
                    }
                }){
                    Text("Login")
                        .fontWeight(.heavy)
                        .font(.title3)
                        .frame(maxWidth: device == .phone ? .infinity : 380)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                }.padding(.top, 40)
                    .padding(.bottom, 20)
                
                
                
                Button(action:{
                    login.createUser(email: email, pass: pass){ (done) in
                        if done{
                            UserDefaults.standard.set(true, forKey: "sesion")
                            loginShow.show.toggle()
                        }
                    }
                }){
                    Text("Sign In")
                        .fontWeight(.heavy)
                        .font(.title3)
                        .frame(maxWidth: device == .phone ? .infinity : 380)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                }
            }.padding(.all)
                
        }
    }
}

