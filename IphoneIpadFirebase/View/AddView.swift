//
//  AddView.swift
//  IphoneIpadFirebase
//
//  Created by Alondra García Morales on 03/11/23.
//

import SwiftUI

struct AddView: View {
    
    @State private var titulo = ""
    @State private var desc = ""
    var consolas = ["playstation", "xbox", "nintendo"]
    @State private var plataforma = "playstation"
    @StateObject var guardar = FirebaseViewModel()
    
    @State private var imageData : Data = .init(Data(capacity: 0))
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    
    @State private var progress = false
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Color.gray.opacity(0.2).ignoresSafeArea(.all)
                VStack{
                    
                    /*NavigationLink(destination: ImagePicker(show: $imagePicker, image: $imageData, source: source), isActive: $imagePicker){
                        EmptyView()
                        
                    }.hidden()*/
                    
                    TextField("Titulo", text: $titulo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextEditor(text: $desc)
                        .frame(height: 200)
                    Picker("Consolas", selection: $plataforma){
                        ForEach(consolas, id:\.self){item in
                            Text(item)
                        }
                    }.accentColor(Color("skyblue")).font(.title2)
                    
                    Button(action: {
                        mostrarMenu.toggle()
                    }){
                        Text("Submit Image")
                            .foregroundStyle(Color("skyblue"))
                            .bold()
                            .font(.largeTitle)
                    }.confirmationDialog("Menu", isPresented: $mostrarMenu, titleVisibility: .visible){
                        Button("Camera", action:{
                            source = .camera
                            imagePicker.toggle()
                        })
                        Button("Libreria", action:{
                            source = .photoLibrary
                            imagePicker.toggle()
                        })
                        
                    } message: {
                        Text("Select an option")
                    }
                    
                    if imageData.count != 0 {
                        Image(uiImage: UIImage(data: imageData)!)
                            .resizable()
                            .frame(width:250, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 3.0))
                        
                        
                        Button(action:{
                            progress = true
                            guardar.save(titulo: titulo, desc: desc, plataforma: plataforma, portada: imageData){ (done) in
                                if done{
                                    titulo = ""
                                    desc = ""
                                    imageData = .init(capacity: 0)
                                    progress = false
                                }
                                
                            }
                        }){
                            Text("Save")
                                .foregroundStyle(.white)
                                .bold()
                                .font(.title)
                                .padding(5)
                                .frame(width: 150, height: 45)
                        }.background(Color("skyblue"))
                         .clipShape(Capsule())
                         .padding(.top, 20)
                         
                        
                        if progress {
                            Text("Loading...").foregroundStyle(.black)
                            ProgressView()
                        }
                    }
                    
                    
                    Spacer()
                    
                }
                .navigationDestination(isPresented: $imagePicker, destination: {ImagePicker(show: $imagePicker, image: $imageData, source: source)})
                .padding(.all)
            }
        }

    }
}

