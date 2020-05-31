//
//  CityViewModel.swift
//  CityFinder
//
//  Created by Manali Mogre on 28/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import UIKit
import CoreLocation

class CityViewModel: NSObject {
    
    private var city: City
    init(city: City) {
        self.city = city
    }
    
    var cityName: String {
        return self.city.cityName
    }
    
    var countryCode: String {
        return self.city.countryCode
    }
    
    var cityTitle: String {
        return "\(self.cityName), \(self.countryCode)"
    }
    
    var citySubTitle: String {
        return "\(self.city.location.latitude), \(self.city.location.longitude)"
    }
    
    var cityLocation: CLLocation {
        return CLLocation(latitude: self.city.location.latitude, longitude: city.location.longitude)
    }
    
    var cityLocationCoordinate: CLLocationCoordinate2D {
       return CLLocationCoordinate2D(latitude:
           self.city.location.latitude, longitude: self.city.location.longitude)
    }
   
}
