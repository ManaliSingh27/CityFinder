//
//  CityViewModel.swift
//  CityFinder
//
//  Created by Manali Mogre on 28/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import UIKit

class CityViewModel: NSObject {

    private var city : City
    init(city : City) {
        self.city = city
    }
    
    var cityName : String
    {
        get{
            return self.city.cityName
        }
    }
    
    var countryCode : String
    {
        get{
            return self.city.countryCode
        }
    }
    
  
    var cityTitle : String
    {
        get{
            return "\(self.cityName), \(self.countryCode)"
        }
    }
    
    var citySubTitle : String
    {
        get{
            return "\(self.city.location.latitude), \(self.city.location.longitude)"
        }
    }
    
}
