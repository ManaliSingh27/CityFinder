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
    var cityId: Int
    var location: Coordinate
    var cityCountryCode: String
    
    enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case countryCode = "country"
        case cityId = "_id"
        case location = "coord"
    }
    
}

extension City: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cityName = try values.decode(String.self, forKey: .cityName)
        countryCode = try values.decode(String.self, forKey: .countryCode)
        cityId = try values.decode(Int.self, forKey: .cityId)
        location = try values.decode(Coordinate.self, forKey: .location)
        cityCountryCode = "\(cityName), \(countryCode)"
    }
}
 
extension City: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cityName, forKey: .cityName)
        try container.encode(countryCode, forKey: .countryCode)
        try container.encode(cityId, forKey: .cityId)
        try container.encode(location, forKey: .location)
     }
}
