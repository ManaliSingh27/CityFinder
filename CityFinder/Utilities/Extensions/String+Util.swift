//
//  String+Util.swift
//  CityFinder
//
//  Created by Manali Mogre on 02/06/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

extension String {
    
    //compute the length
    var length: Int {
        return self.count
    }
    
    //returns characters up to a specified integer
    func substring(toIndex: Int) -> String {
        
        //define the range
        let range = self.index(self.startIndex, offsetBy: toIndex)
        return String(self[..<range]).lowercased()
    }
}
