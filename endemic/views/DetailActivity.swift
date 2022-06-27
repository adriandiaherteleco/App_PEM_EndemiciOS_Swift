//
//  DetailView.swift
//  endemic
//
//  Created by Adrián  Díaz Hernández on 19/6/22.
//

import SwiftUI

struct DetailActivity: View {
    
    var FloraItem : FloraItem
    @StateObject var crud = Endemic()
    @State private var show = false
    
    
    
    var body: some View {
        VStack(){
            
            
            AsyncImage(url: URL(string: FloraItem.imagen)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                    
                } placeholder: {
                    Color.red
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .shadow(radius: 10)
            
            VStack(alignment: .leading){
                Text("")
                Text(FloraItem.nombre).font(.title2).bold()
                Text("")
                Text(FloraItem.nombreCientifico).font(.body)
                Text("")
                Text(FloraItem.habitat).font(.body)
                Text("")
                Text(FloraItem.notas).font(.body)
                Text("")


            }
               
                
                Button {
                    crud.delete(id: FloraItem.id)
                } label: {
                    Text("ELIMINAR")
                }.buttonStyle(.bordered)
                    .tint(.red)
        
            
            Spacer()
        }.padding(.all)
            .alert(crud.mensaje, isPresented: $crud.show) {
                Button("Aceptar", role: .none) {
                    
                }
            }
    }
}
