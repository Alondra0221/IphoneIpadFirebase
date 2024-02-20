//
//  EditarView.swift
//  IphoneIpadFirebase
//
//  Created by Alondra García Morales on 25/11/23.
//

import SwiftUI

struct EditarView: View {
    
    @State private var titulo = ""
    @State private var desc = ""

    var plataforma : String
    var datos : FirebaseModel
    @StateObject var guardar = FirebaseViewModel()
    
    @State private var imageData : Data = .init(Data(capacity: 0))
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    
    @State private var progress = false
    @Environment(\.dismiss) var presentationMode
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Color.gray.opacity(0.2).ignoresSafeArea(.all)
                VStack{
                    
                    
                    
                    TextField("Titulo", text: $titulo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onAppear{
                            titulo = datos.titulo
                        }
                    TextEditor(text: $desc)
                        .frame(height: 200)
                        .onAppear{
                            desc = datos.desc
                        }
                    
                    Button(action: {
                        mostrarMenu.toggle()
                    }){
                        Text("Submit Image")
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
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
                        Button("Cancel", action:{
                            
                            imagePicker.toggle()
                        })
                        
                    } message: {
                        Text("Select an option")
                    }
                    
                    if imageData.count != 0 {
                        Image(uiImage: UIImage(data: imageData)!)
                            .resizable()
                            .frame(width:250, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                    }
                    
                    Button(action:{
                        if imageData.isEmpty{
                            guardar.edit(titulo: titulo, desc: desc, plataforma: plataforma, id: datos.id){(done) in
                                if done{
                                    presentationMode()
                                }
                            }
                        }else{
                            progress = true
                            guardar.editWithImage(titulo: titulo, desc: desc, plataforma: plataforma, id: datos.id, index: datos, portada: imageData){(done) in
                                if done{
                                    presentationMode()
                                }
                            }
                        }
                    }){
                        Text("Edit")
                            .foregroundStyle(.white)
                            .bold()
                            .font(.title)
                            .padding(5)
                            .frame(width: 150, height: 45)
                    }.background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                     .clipShape(Capsule())
                     .padding(.top, 20)
                     
                    
                    if progress {
                        Text("Loading...").foregroundStyle(.black)
                        ProgressView()
                    }
                    
                    
                    Spacer()
                    
                }
                .navigationDestination(isPresented: $imagePicker, destination: {ImagePicker(show: $imagePicker, image: $imageData, source: source)})
                .padding(.all)
                
            }
        }
    }
}

