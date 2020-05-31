//
//  CityListViewModel.swift
//  CityFinder
//
//  Created by Manali Mogre on 28/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import UIKit

protocol CityListViewModelDelegate: class {
    func parseCitiesSuccess()
    func parseCitiesFailureWithMessage(message: String)
}

protocol FilteredCityViewModelDelegate: class {
    func citiesFilteredSuccess()
}

class CityListViewModel: NSObject {
    
    private var parserObj  = CityParserViewModel()
    private var filterCitiesObj = FilterCityViewModel()
    private var filterManager: FilterDataViewModel!
    private var cities: [City] {
        didSet {
            self.delegate?.parseCitiesSuccess()
        }
    }
    
    private var filteredCities: [City] {
        didSet {
            self.filteredCityDelegate?.citiesFilteredSuccess()
        }
    }
   
    weak var delegate: CityListViewModelDelegate?
    weak var filteredCityDelegate: FilteredCityViewModelDelegate?
    
    init(delegate: CityListViewModelDelegate?, filteredCityDelegate: FilteredCityViewModelDelegate?) {
        self.cities = [City]()
        self.filteredCities = [City]()
        self.delegate = delegate
        self.filteredCityDelegate = filteredCityDelegate
        self.filterManager = FilterDataViewModel(filter: filterCitiesObj)

    }
    
   func getCitiesList() {
        let parserManager = ParserViewModel(dataParser: parserObj)

         parserManager.parseJson(resourceFile: "cities", completion: {(result) in
            switch result {
            case .success(let cityResponse):
                // Sorting the List alphabetically based on City Name
                let cityArray = cityResponse as? [City]
                self.cities =  (cityArray?.sorted {$0.cityName < $1.cityName})! 
            case .error(let error):
                print(error)
                self.delegate?.parseCitiesFailureWithMessage(message: error)
            }
        })
    }
        
    func numberOfCities(isFiltering: Bool) -> Int {
        return isFiltering ? self.filteredCities.count : self.cities.count
    }
    
    func cityAtIndex(isFiltering: Bool, index: Int) -> CityViewModel {
        return isFiltering ? CityViewModel(city: self.filteredCities[index]) : CityViewModel(city: self.cities[index])
    }
    
    // Search Bar
    func filterCities(searchedText: String) {
        self.filteredCities = self.filterManager.filterData(searchedText: searchedText, data: self.cities) 
    }
}
