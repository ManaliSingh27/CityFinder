//
//  FilterDataViewModel.swift
//  CityFinder
//
//  Created by Manali Mogre on 29/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import Foundation

protocol FilterData
{
    func filterData(searchedText:String, data:Array<City>) -> Array<City>
}

class FilterDataViewModel
{
    var filterDataObj : FilterData
    
    init(filter : FilterData) {
        self.filterDataObj = filter
    }
    
    func filterData(searchedText:String, data:Array<City>) -> Array<City>
    {
        return (filterDataObj.filterData(searchedText: searchedText, data: data))
    }
}

class FilterCityViewModel:FilterData
{
    func filterData(searchedText: String, data: Array<City>) -> Array<City> {
        let filteredCities = data.filter { (city: City) -> Bool in
            return city.cityName.lowercased().starts(with: searchedText.lowercased())
        }
        return filteredCities
    }
    
    
}
