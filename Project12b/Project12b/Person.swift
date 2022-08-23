//
//  Person.swift
//  Project12b
//
//  Created by Muhammed Burkay Şendoğdu on 27.07.2022.
//

import UIKit

class Person: NSObject,Codable {
    var name: String
    var image: String
    
    init(name: String, image: String){
        self.name = name
        self.image = image
    }

}
