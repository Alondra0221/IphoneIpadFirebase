//
//  ImagenFirebase.swift
//  IphoneIpadFirebase
//
//  Created by Alondra García Morales on 25/11/23.
//

import SwiftUI

struct ImagenFirebase: View {
    
    let imagenAlternativa = UIImage(systemName: "photo")
    @ObservedObject var imageLoader : PortadaViewModel
    
    init(imageUrl: String){
        imageLoader = PortadaViewModel(imageUrl: imageUrl)
    }
    
    var image : UIImage?{
        imageLoader.data.flatMap(UIImage.init)
    }
    var body: some View {
        Image(uiImage: image ?? imagenAlternativa!)
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 5)
            .aspectRatio(contentMode: .fit)
    }
}


