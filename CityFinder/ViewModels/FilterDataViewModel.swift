//
//  FilterDataViewModel.swift
//  CityFinder
//
//  Created by Manali Mogre on 29/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import Foundation

protocol FilterData {
    func filterData(searchedText: String, data: CityNodeViewModel) -> [CityViewModel]?
}

class FilterDataViewModel {
    var filterDataObj: FilterData
    
    init(filter: FilterData) {
        self.filterDataObj = filter
    }
    
    func filterData(searchedText: String, data: CityNodeViewModel) -> [CityViewModel]? {
        return (filterDataObj.filterData(searchedText: searchedText, data: data))
    }
}

final class FilterCityViewModel: FilterData {
    /// Filters the Cities Array based on the text searched
    /// - parameter searchedText: Text to be matched in the data
    /// - parameter data: Array of cities
    /// - returns:  Array of Filtered Cities
    func filterData(searchedText: String, data: CityNodeViewModel) -> [CityViewModel]? {
        let filteredCityModel: [CityViewModel]? = data.find(keyword: searchedText)
        return filteredCityModel
    }
}
