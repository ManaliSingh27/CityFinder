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
    let trie = Trie()

    private var cities: [City] {
        didSet {
            self.delegate?.parseCitiesSuccess()
        }
    }
    
    private var filteredCities: [CityViewModel] {
        didSet {
            self.filteredCityDelegate?.citiesFilteredSuccess()
        }
    }
   
    weak var delegate: CityListViewModelDelegate?
    weak var filteredCityDelegate: FilteredCityViewModelDelegate?
    
    init(delegate: CityListViewModelDelegate?, filteredCityDelegate: FilteredCityViewModelDelegate?) {
        self.cities = [City]()
        self.filteredCities = [CityViewModel]()
        self.delegate = delegate
        self.filteredCityDelegate = filteredCityDelegate
        self.filterManager = FilterDataViewModel(filter: filterCitiesObj)

    }
    
/// Parse the json file and saves the city list in cities array
   func getCitiesList() {
        let parserManager = ParserViewModel(dataParser: parserObj)
         parserManager.parseJson(resourceFile: "cities", completion: {(result) in
          //  guard let self = self else { return }

            switch result {
            case .success(let cityResponse):
                let cityArray = cityResponse as? [City]
                self.cities = cityArray!
                self.saveCitiesDataInTrieFormat()
            case .error(let error):
                print(error)
                self.delegate?.parseCitiesFailureWithMessage(message: error)
            }
        })
    }
    
    func saveCitiesDataInTrieFormat() {
        for city in self.cities {
            trie.append(word: city.cityCountryCode, viewModel: CityViewModel(city: city))
        }
    }
    
    /// Returns the number of cities based on the search text entered.
    /// - parameter isFiltering: Bool value indicating if a text is entered in search bar
    /// - returns:  Count of Cities
    func numberOfCities(isFiltering: Bool) -> Int {
        return isFiltering ? self.filteredCities.count : self.cities.count
    }
    
    /// Returns the City View Model based on the search text and the row index
    /// - parameter isFiltering: Bool value indicating if a text is entered in search bar
    /// - parameter index: Index of the row to get the City View Model
    /// - returns:  City View Model
    func cityAtIndex(isFiltering: Bool, index: Int) -> CityViewModel {
        return isFiltering ? self.filteredCities[index] : CityViewModel(city: self.cities[index])
    }
    
    /// Updates the filteredCities array based on the searched text
    /// - parameter searchedText: Text entered in search bar
    func filterCities(searchedText: String) {
        self.filteredCities =
            self.filterManager.filterData(searchedText: searchedText, data: trie) ?? [CityViewModel]()
    }
}
