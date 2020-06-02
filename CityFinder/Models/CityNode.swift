//
//  CityNode.swift
//  CityFinder
//
//  Created by Manali Mogre on 02/06/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

public class CityNode {
    
    var key: String?
    var children: [CityNode]
    var isFinal: Bool
    var level: Int
    var cityModel: CityViewModel?
    
    init() {
        self.children = [CityNode]()
        self.isFinal = false
        self.level = 0
    }
}
