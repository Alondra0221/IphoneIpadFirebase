//
//  CardView.swift
//  IphoneIpadFirebase
//
//  Created by Alondra García Morales on 01/11/23.
//

import SwiftUI

struct CardView: View {
    
    var titulo : String
    var portada : String
    
    var index : FirebaseModel
    var plataforma : String
    
    @StateObject var datos = FirebaseViewModel()
    
    var body: some View {
        VStack(spacing: 20){
            ImagenFirebase(imageUrl: portada)
            Text(titulo)
                .font(.title)
                .bold().foregroundStyle(.black)
            Button(action:{
                datos.delete(index: index, plataforma: plataforma)
            }){
                Text("Delete")
                    .foregroundStyle(.red)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
                    .background(Capsule().stroke(Color.red))
            }
        }.padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

