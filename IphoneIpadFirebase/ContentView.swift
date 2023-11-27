//
//  ContentView.swift
//  IphoneIpadFirebase
//
//  Created by Alondra García Morales on 01/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var loginShow : FirebaseViewModel
    
    var body: some View {
        
        return Group{
            if loginShow.show{
                Home()
                    .ignoresSafeArea(.all)
                    
            }else{
                Login()
            }
        }.onAppear{
            if(UserDefaults.standard.object(forKey: "sesion")) != nil {
                loginShow.show = true
            }
        }
        
    }
}


