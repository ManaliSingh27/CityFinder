//
//  City.swift
//  CityFinder
//
//  Created by Manali Mogre on 28/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import Foundation

struct City {
    var cityName: String
    var countryCode: String
    var location: Coordinate
    
    enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case countryCode = "country"
        case location = "coord"
    }
    
}

extension City: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cityName = try values.decode(String.self, forKey: .cityName)
        countryCode = try values.decode(String.self, forKey: .countryCode)
        location = try values.decode(Coordinate.self, forKey: .location)
    }
}
