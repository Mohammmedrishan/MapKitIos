//
//  cityLocation.swift
//  MapUI
//
//  Created by Mohammed Rishan on 22/07/1941 Saka.
//  Copyright © 1941 Mohammed Rishan. All rights reserved.
//

import UIKit
import MapKit
class cityLocation: NSObject,MKAnnotation{
    
    var identifer = "city location"
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(name: String,lat: CLLocationDegrees, long: CLLocationDegrees) {
        title = name
        coordinate = CLLocationCoordinate2DMake(lat, long)
    }
}
class CityLocations: NSObject{
    var hospital = [cityLocation]()
    override init() {
        hospital += [cityLocation(name: "Amirtha",lat: 10.0335,long: 76.2919)]
        hospital += [cityLocation(name: "Aster", lat: 10.0548, long: 76.5919)]
        hospital += [cityLocation(name: "Lakeshore", lat: 10.0876, long: 76.3982)]
        hospital += [cityLocation(name: "Rajagiri", lat: 10.0531, long: 76.3890)]
    }
}
