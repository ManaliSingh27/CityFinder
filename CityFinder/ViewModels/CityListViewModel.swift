//
//  CityListViewModel.swift
//  CityFinder
//
//  Created by Manali Mogre on 28/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import UIKit

protocol CityListViewModelDelegate : NSObject
{
    func parseCitiesSuccess()
    func parseCitiesFailureWithMessage(message : String)
}

protocol FilteredCityViewModelDelegate : NSObject
{
    func citiesFilteredSuccess()
}

class CityListViewModel: NSObject {
    
    private var parserObj  = CityParserViewModel()
    private var filterCitiesObj = FilterCityViewModel()
    private var filterManager : FilterDataViewModel!
    

    private var cities : Array<City>{
        didSet
        {
            self.delegate?.parseCitiesSuccess()
        }
    }
    
    private var filteredCities : Array<City>{
        didSet
        {
            self.filteredCityDelegate?.citiesFilteredSuccess()
        }
    }
   
    weak var delegate : CityListViewModelDelegate?
    weak var filteredCityDelegate : FilteredCityViewModelDelegate?
    
    init(delegate : CityListViewModelDelegate?, filteredCityDelegate : FilteredCityViewModelDelegate?)
    {
        self.cities = Array<City>()
        self.filteredCities = Array<City>()
        self.delegate = delegate
        self.filteredCityDelegate = filteredCityDelegate
        self.filterManager = FilterDataViewModel(filter: filterCitiesObj)

    }
    
   func getCitiesList()
    {
        let parserManager = ParserViewModel(dataParser: parserObj)

         parserManager.parseJson(resourceFile: "cities", completion: {(result) in
            switch(result)
            {
            case .Success(let cityResponse):
               // self.cities = cityResponse as! Array<City>
                // Sorting the List alphabetically based on City Name
                let cityArray = cityResponse as! Array<City>
                
                self.cities =  cityArray.sorted{$0.cityName < $1.cityName} 
            case .Error(let error):
                print(error)
                self.delegate?.parseCitiesFailureWithMessage(message: error)

            }
        })
    }
    
  
    
    func numberOfCities()->Int
    {
        return self.cities.count
    }
    
    func cityAtIndex(index : Int) -> CityViewModel
    {
        return CityViewModel(city: self.cities[index])
    }

    
    // Search Bar
    func filterCities(searchedText : String)
    {
        self.filteredCities = self.filterManager.filterData(searchedText: searchedText, data: self.cities) 
    }
    
    func numberOfFilteredCities()->Int
    {
        return self.filteredCities.count
    }
    
    func filteredCityAtIndex(index : Int) -> CityViewModel
    {
        return CityViewModel(city: self.filteredCities[index])
    }
}
