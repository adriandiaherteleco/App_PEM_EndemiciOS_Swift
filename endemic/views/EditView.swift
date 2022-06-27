//
//  EditView.swift
//  endemic
//
//  Created by Adrián  Díaz Hernández on 19/6/22.
//

import SwiftUI

struct EditView: View {
    
    var crudItem : Posts
    @StateObject var crud = Endemic()
    @State private var titulo = ""
    @State private var contenido = ""
    
    var body: some View {
        Form{
            TextField("Titulo", text: $titulo)
                .onAppear{
                    titulo = crudItem.titulo
                }
            TextEditor(text: $contenido)
                .onAppear{
                    contenido = crudItem.contenido
                }
        }
    }
}


