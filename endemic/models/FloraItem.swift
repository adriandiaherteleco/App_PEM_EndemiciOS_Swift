//
//  Posts.swift
//  endemic
//
//  Created by Adrián  Díaz Hernández on 19/6/22.
//

import Foundation

struct FloraItem: Codable {
    let id : String
    let nombre : String
    let nombreCientifico : String
    let habitat : String
    let notas : String
    let imagen : String
}
