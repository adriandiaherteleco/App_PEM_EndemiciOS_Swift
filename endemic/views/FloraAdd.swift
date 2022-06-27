//
//  PostView.swift
//  endemic
//
//  Created by Adrián  Díaz Hernández on 19/6/22.
//

import SwiftUI

struct FloraAdd: View{
    @StateObject var crud = Endemic()

        @State private var nombre = ""
        @State private var nombreCientifico = ""
        @State private var habitat = ""
        @State private var notas = ""
        
        @State private var showImagePIcker = false
        @State private var image: Image?
        @State private var inputImage: UIImage?
        
        func loadImage(){
            guard let inputImage = inputImage else { return  }
            image = Image(uiImage: inputImage)
        }
        
        var body: some View {
            Form {
                TextField("Nombre", text: $nombre)
                TextField("Nombre Cientítico", text: $nombreCientifico)
                TextField("Habitat", text: $habitat)
                TextField("Notas", text: $notas)

                Button {
                    if image == nil {
                        crud.save(nombre: nombre, nombreCientifico: nombreCientifico, habitat: habitat, notas: notas, id: "")
                    }else{
                        crud.save2(nombre: nombre, nombreCientifico: nombreCientifico, habitat: habitat, notas: notas, imagen: inputImage!)
                    }
                    
                    nombre = ""
                    nombreCientifico = ""
                    habitat = ""
                    notas = ""
                    image = nil
                } label: {
                    Text("INSERTAR")
                }
                .alert(crud.mensaje, isPresented: $crud.show) {
                    Button("Aceptar", role: .none) {
                        
                    }
                }
                image?
                    .resizable()
                    .scaledToFit()
            }.navigationTitle("Registro de Flora")
                .toolbar{
                    Button {
                        showImagePIcker = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .onChange(of: inputImage) { _ in
                    loadImage()
                }.sheet(isPresented: $showImagePIcker) {
                    ImagePicker(image: $inputImage)
                }


        }
    }


