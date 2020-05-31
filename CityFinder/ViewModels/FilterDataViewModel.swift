//
//  FilterDataViewModel.swift
//  CityFinder
//
//  Created by Manali Mogre on 29/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import Foundation

protocol FilterData {
    func filterData(searchedText: String, data: [City]) -> [City]
}

class FilterDataViewModel {
    var filterDataObj: FilterData
    
    init(filter: FilterData) {
        self.filterDataObj = filter
    }
    
    func filterData(searchedText: String, data: [City]) -> [City] {
        return (filterDataObj.filterData(searchedText: searchedText, data: data))
    }
}

final class FilterCityViewModel: FilterData {
    func filterData(searchedText: String, data: [City]) -> [City] {
        
        let filteredCities = data.filter { $0.cityCountryCode.lowercased().hasPrefix(searchedText.lowercased())}
        return filteredCities
        
    }
}
