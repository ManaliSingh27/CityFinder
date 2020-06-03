//
//  FilterViewModelTests.swift
//  CityFinderTests
//
//  Created by Manali Mogre on 29/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import XCTest
@testable import CityFinder

class FilterViewModelTests: XCTestCase {
    
    private var filterCitiesObj = FilterCityViewModel()
    private var filterModelObj: FilterDataViewModel!
    private var cityNodeModelObj = CityNodeViewModel()
    
    private var citiesViewModels: [CityViewModel]!
    override func setUp() {
        citiesViewModels = buildCityViewModels()
        filterModelObj = FilterDataViewModel(filter: filterCitiesObj)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func createCityModelData() -> [City] {
        let cities = [
            City(
                cityName: "Alabama", countryCode: "US", location: Coordinate(latitude: 10.90, longitude: 18.90)
            ),
            City(
                cityName: "Alabama", countryCode: "US", location: Coordinate(latitude: 11.90, longitude: 19.90)
            ),
            City(
                cityName: "Alabama", countryCode: "US", location: Coordinate(latitude: 10.90, longitude: 18.90)
            ),
            City(
                cityName: "Albuquerque", countryCode: "US", location: Coordinate(latitude: 10.90, longitude: 18.90)
            ),
            City(
                cityName: "Anaheim", countryCode: "US", location: Coordinate(latitude: 10.90, longitude: 18.90)
            ),
            City(
                cityName: "Arizona", countryCode: "US", location: Coordinate(latitude: 10.90, longitude: 18.90)
            ),
            City(
                cityName: "Sydney", countryCode: "AU", location: Coordinate(latitude: 10.90, longitude: 18.90)
            ),
            City(
                cityName: "Amsterdam", countryCode: "NL", location: Coordinate(latitude: 10.90, longitude: 18.90)
            ),
            City(
                cityName: "Amsterdam-Zuidoost", countryCode: "NL", location: Coordinate(latitude: 10.90, longitude: 18.90)
            ),
            City(
                cityName: "Amsham", countryCode: "DE", location: Coordinate(latitude: 10.90, longitude: 18.90)
            ),
            City(
            cityName: "Mumbai", countryCode: "IN", location: Coordinate(latitude: 10.90, longitude: 18.90)
                  )
        ]
        return cities
    }
    
    private func buildCityViewModels() -> [CityViewModel] {
        var viewModels = [CityViewModel]()
        self.createCityModelData().forEach {
            viewModels.append(CityViewModel(city: $0))
        }
        return viewModels
    }
    
    private func createRandomNumericString(length: Int) -> String {
        let letters = "0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
    
    private func createRandomSpecialCharString(length: Int) -> String {
        let passwordRegex = "^[0-9 !\"#$%&()*+,-./:;<=>?@\\[\\\\\\]_{|}~].{8,}$"
        return String((0..<length).map { _ in passwordRegex.randomElement()! })

    }

    func testCreateCityNodeData() {
        citiesViewModels.forEach {
            cityNodeModelObj.append(viewModel: $0)
        }
    }
    
    func testFilterWithSingleSearchCharacter() {
        testCreateCityNodeData()
        let filteredCityViewModels: [CityViewModel] = filterModelObj.filterData(searchedText: "A", data: cityNodeModelObj)!
        XCTAssertTrue(filteredCityViewModels.contains {$0.cityName == "Alabama"})
        XCTAssertTrue(filteredCityViewModels.contains {$0.cityName == "Albuquerque"})
        XCTAssertTrue(filteredCityViewModels.contains {$0.cityName == "Anaheim"})
        XCTAssertTrue(filteredCityViewModels.contains {$0.cityName == "Arizona"})
        XCTAssertTrue(filteredCityViewModels.contains {$0.cityName == "Amsterdam"})
        XCTAssertTrue(filteredCityViewModels.contains {$0.cityName == "Amsterdam-Zuidoost"})
        XCTAssertTrue(filteredCityViewModels.contains {$0.cityName == "Amsham"})
        XCTAssertFalse(filteredCityViewModels.contains {$0.cityName == "Sydney"})
        XCTAssertFalse(filteredCityViewModels.contains {$0.cityName == "Mumbai"})
    }
    
    func testFilterWithMultipleSearchCharacter() {
        testCreateCityNodeData()
        let filteredCityViewModels: [CityViewModel] = filterModelObj.filterData(searchedText: "ams", data: cityNodeModelObj)!
        XCTAssertTrue(filteredCityViewModels.contains {$0.cityName == "Amsterdam"})
        XCTAssertTrue(filteredCityViewModels.contains {$0.cityName == "Amsterdam-Zuidoost"})
        XCTAssertTrue(filteredCityViewModels.contains {$0.cityName == "Amsham"})
        XCTAssertFalse(filteredCityViewModels.contains {$0.cityName == "Sydney"})
        XCTAssertFalse(filteredCityViewModels.contains {$0.cityName == "Mumbai"})
        XCTAssertFalse(filteredCityViewModels.contains {$0.cityName == "Alabama"})
        XCTAssertFalse(filteredCityViewModels.contains {$0.cityName == "Albuquerque"})
        XCTAssertFalse(filteredCityViewModels.contains {$0.cityName == "Anaheim"})
        XCTAssertFalse(filteredCityViewModels.contains {$0.cityName == "Arizona"})
    }
    
    func testFilterWithDuplicateCity() {
        testCreateCityNodeData()
        let filteredCityViewModels: [CityViewModel] = filterModelObj.filterData(searchedText: "Alabama", data: cityNodeModelObj)!
        XCTAssertTrue(filteredCityViewModels.count == 3)
    }
    
    func testFilterWithInvalidInput() {
        testCreateCityNodeData()
        let filteredCityViewModels: [CityViewModel] = filterModelObj.filterData(searchedText: createRandomSpecialCharString(length: 4), data: cityNodeModelObj) ?? [CityViewModel]()
        XCTAssertTrue(filteredCityViewModels.isEmpty)
    }
    
    func testFilterWithRandomCityName() {
        testCreateCityNodeData()
        let cityNames = citiesViewModels.map {$0.cityName}
        let searchedCity  = cityNames.randomElement()
        let filteredCities: [CityViewModel] = filterModelObj.filterData(searchedText: searchedCity!, data: cityNodeModelObj)!
        XCTAssertFalse(filteredCities.isEmpty)
    }
    
    func testFilterWithEmptyString() {
        testCreateCityNodeData()
        let filteredCities: [CityViewModel]? = filterModelObj.filterData(searchedText: "", data: cityNodeModelObj) ?? [CityViewModel]()
        XCTAssertTrue(filteredCities!.isEmpty)
    }
}
