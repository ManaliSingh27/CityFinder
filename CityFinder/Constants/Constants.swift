//
//  Constants.swift
//  CityFinder
//
//  Created by Manali Mogre on 31/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import Foundation
import UIKit
struct Constants {
   static let kBlueColor: UIColor = UIColor.init(red: 84.0/255.0, green: 169.0/255.0, blue: 205.0/255.0, alpha: 1.0)
    static let kHelveticaBold22Font: UIFont = UIFont(name: "Helvetica-Bold", size: 22)!
    static let kCitiesJSON: String = "cities"
    static let kSearchPlaceholderString: String = "Find a City"
    
}

struct ErrorConstants {
    static let kParsingFailedError: String = "Parsing Failed"
    static let kError: String = "Error"
}

struct StoryboardConstants {
    static let kCityDetailedSegue: String = "showDetailedCitySegue"
}
