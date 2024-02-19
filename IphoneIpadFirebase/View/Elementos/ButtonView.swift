//
//  ButtonView.swift
//  IphoneIpadFirebase
//
//  Created by Alondra García Morales on 01/11/23.
//

import SwiftUI

struct ButtonView: View {
    @Binding var index : String
    @Binding var menu : Bool
    var device = UIDevice.current.userInterfaceIdiom
    
    var title : String
    
    var body: some View {
        Button(action:{
            
            withAnimation{
                index = title
                if device == .phone{
                    menu.toggle()
                }
            }
            
        }){
            Text(title)
                .font(.title)
                .fontWeight(index == title ? .bold : .none)
                .foregroundStyle(index == title ? LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing) )
                
        }
    }
}

