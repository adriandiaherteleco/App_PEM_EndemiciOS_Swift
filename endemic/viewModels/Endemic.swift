//
//  Endemic.swift
//  endemic
//
//  Created by Adrián  Díaz Hernández on 19/6/22.
//

import Foundation
import Alamofire
import UIKit

class Endemic : ObservableObject{
    
    @Published var mensaje = ""
    @Published var show = false
    @Published var posts = [FloraItem]()
    
    //URLS to DB PHP
    var urlSave = "http://www.vculhbvl.lucusprueba.es/save.php"
    var urlMostrar = "http://www.vculhbvl.lucusprueba.es/select.php"
    var urlDelete = "http://www.vculhbvl.lucusprueba.es/delete.php"
    
    
    func save(nombre: String, nombreCientifico: String, habitat: String, notas: String, id: String){
        
        let parametros : Parameters = [
            "nombre": nombre,
            "nombreCientifico": nombreCientifico,
            "habitat": habitat,
            "notas": notas,
            "id":id
        ]
        
        
        
        guard let url = URL(string: urlSave) else { return }
        
        DispatchQueue.main.async {
            AF.request(url, method: .post, parameters: parametros).responseData { response in
                switch response.result {
                case .success(let data):
                    do{
                        let json = try JSONSerialization.jsonObject(with: data)
                        let resultadojson = json as! NSDictionary
                        guard let res = resultadojson.value(forKey: "respuesta") else { return }
                        if res as! String == "success"{
                            self.mensaje = "Post guardado con exito"
                            self.show = true

                        }else{
                            self.mensaje = "El post no se pudo guardar"
                            self.show = true
                        }
                    }catch let error as NSError {
                        print("Error en el json", error.localizedDescription)
                        self.mensaje = "El post no se pudo guardar"
                        self.show = true
                    }
                case .failure(let error):
                    print(error)
                    self.mensaje = "El post no se pudo guardar"
                    self.show = true
                }
            }
        }
        
    }
    
    
    func save2(nombre: String, nombreCientifico: String, habitat: String, notas: String, imagen: UIImage){
        let parametros : Parameters = [
            "nombre": nombre,
            "nombreCientifico": nombreCientifico,
            "habitat": habitat,
            "notas": notas
        ]
        
        guard let url = URL(string: urlSave) else { return }
        
        guard let imgData = imagen.jpegData(compressionQuality: 100.0) else { return }
        let nombreImagen = UUID().uuidString
        
        DispatchQueue.main.async {
            AF.upload(multipartFormData: { MultipartFormData in
                
                MultipartFormData.append(imgData, withName: "imagen", fileName: "\(nombreImagen).png", mimeType: "image/png")
                
                for (key, val) in parametros {
                    MultipartFormData.append((val as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                
            }, to: url, method: .post).uploadProgress { Progress in
                print(Progress.fractionCompleted * 100)
            }.response { response in
                self.mensaje = "Post guardado con exito"
                self.show = true
            }
        }
        
    }
    
    
    func getData(){
        AF.request(urlMostrar)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do{
                        let json = try JSONDecoder().decode([FloraItem].self, from: data)
                        DispatchQueue.main.async {
                            print(json)
                            self.posts = json
                        }
                    }catch let error as NSError {
                        print("error al mostrar json", error.localizedDescription)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    func delete(id: String){
        
        let parametros : Parameters = [
            "id": id,
        ]
        
        guard let url = URL(string: urlDelete) else { return }
        
        DispatchQueue.main.async {
            AF.request(url, method: .post, parameters: parametros).responseData { response in
                switch response.result {
                case .success(let data):
                    do{
                        let json = try JSONSerialization.jsonObject(with: data)
                        let resultadojson = json as! NSDictionary
                        guard let res = resultadojson.value(forKey: "respuesta") else { return }
                        if res as! String == "success"{
                            self.mensaje = "Post eliminado con exito"
                            self.show = true
                        }else{
                            self.mensaje = "El post no se pudo eliminar"
                            self.show = true
                        }
                    }catch let error as NSError {
                        print("Error en el json", error.localizedDescription)
                        self.mensaje = "El post no se pudo eliminar"
                        self.show = true
                    }
                case .failure(let error):
                    print(error)
                    self.mensaje = "El post no se pudo eliminar"
                    self.show = true
                }
            }
        }
        
    }
    
    
}
