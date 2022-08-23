//
//  Capital.swift
//  Project16Repeat
//
//  Created by Muhammed Burkay Şendoğdu on 29.07.2022.
//

import UIKit
import MapKit
class Capital: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var info: String
    var title: String?
    
    init(title: String, info: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.info = info
        self.coordinate = coordinate
    }

}
