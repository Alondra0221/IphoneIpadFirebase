//
//  ListView.swift
//  IphoneIpadFirebase
//
//  Created by Alondra García Morales on 25/11/23.
//

import SwiftUI

struct ListView: View {
    
    var device = UIDevice.current.userInterfaceIdiom
    //@Environment(\.horizontalSizeClass) var width
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    //Funcion para el Iphone 15 Pro Max
    /*func getColumns() -> Int{
        return (device == .pad) ? 3 : ((device == .phone && width == .regular) ? 3 : 1 )
    }*/
    
    //Funcion para el Iphone 15 Pro y tambien Iphone 15 Pro max
    func getColumns() -> Int{
        if device == .pad || (horizontalSizeClass == .regular && verticalSizeClass == .compact){
            return 3
        }else {
            return 1
        }
    }
    
    var plataforma : String
    @StateObject var datos = FirebaseViewModel()
    //@State private var showeditar = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators:false){
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: getColumns()), spacing: 20 ) {
                
                ForEach(datos.datos){ item in
                    CardView(titulo: item.titulo, portada: item.portada, index: item, plataforma: plataforma)
                        .onTapGesture {
                            datos.sendData(item: item)
                        }.sheet(isPresented: $datos.showeditar, content: {
                            EditarView(plataforma: plataforma, datos: datos.itemUpdate)
                        })
                        .padding(.all)
                }
            }
        }.onAppear{
            datos.getData(plataforma: plataforma)
        }
    }
}
