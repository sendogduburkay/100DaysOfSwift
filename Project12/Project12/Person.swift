//
//  Person.swift
//  Project12
//
//  Created by Muhammed Burkay Şendoğdu on 26.07.2022.
//
/*
 Eğer nesne bir class ise NSCoding protokolüne uymalı.
 Structlar NSCoding ile çalışmıyor.
 NSCoding kullanırken NSObject'te inherit almazsa çöküyor.
 
 
 
 */
import UIKit

class Person: NSObject,Codable /* NSCoding */  {
    var name: String
    var image: String
    init(name: String, image: String){
        self.name = name
        self.image = image
    }
    
    /* UserDefault işlemlerini yapmak için NSCoder adlı sınıfı kullanıyoruz. Bu sınıf verilerin yazılmasında(encode) ve okunmasında(decode) sorumluluk alıyor. NSCoding'e uydurabilmek için new initializer isteniyor. Bu initi de "required" anahtar kelimesi ile kullanmak zorundayız. Bu şu demek; Eğer bu sınıfı alt sınıf olarak kullanacak biri var ise bu init kullanılacaktır.*/
    
    /* Sınıfın nesneleri yüklenirken kullanılır.(okunma işlemi)*/
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
    /* kaydederken encode kullanılır.(yazılma işlemi)*/
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(image,forKey: "image")
    }

}
