//
//  Home.swift
//  endemic
//
//  Created by Adrián  Díaz Hernández on 19/6/22.
//

import SwiftUI

struct MainActivity: View {
    
    @StateObject var crud = Endemic()
    
    var body: some View {

        NavigationView{
            List{
                ForEach(crud.posts, id:\.id){ item in
                    NavigationLink(destination: DetailActivity(FloraItem: item)){
                        CeldaView(imagen: item.imagen, nombre: item.nombre, nombreCientifico: item.nombreCientifico, habitat: item.habitat, notas: item.notas)
                    }
                }
            }
            .navigationTitle("Endemic")
            .listStyle(.plain)
            .toolbar{
                NavigationLink(destination: FloraAdd()){
                    Image(systemName: "plus")
                    
                }
            }.onAppear{
                crud.getData()
            }
        }
    }
}

struct CeldaView: View {
    
    var imagen: String
    var nombre : String
    var nombreCientifico : String
    var habitat : String
    var notas : String
    
    var body: some View {
        
        HStack{
            AsyncImage(url: URL(string: imagen)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)
                
            } placeholder: {
                Color.red
            }
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(radius: 10)
        }
        VStack(alignment: .leading){
            Text(nombre).font(.title2).bold()
            Text(nombreCientifico).font(.body).foregroundColor(Color.gray)

        }
    }
}


