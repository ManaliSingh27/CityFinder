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
    
    private var cities: [City]!
    override func setUp() {
        cities = createCityModelData()
        filterModelObj = FilterDataViewModel(filter: filterCitiesObj)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func createCityModelData() -> [City] {
        let cities = [
            City(
                cityName: "Alabama", countryCode: "US", cityId: 1, location: Coordinate(latitude: 10.90, longitude: 18.90), cityCountryCode: "Alabama, US"
            ),
            City(
                cityName: "Albuquerque", countryCode: "US", cityId: 2, location: Coordinate(latitude: 10.90, longitude: 18.90), cityCountryCode: "Albuquerque, US"
            ),
            City(
                cityName: "Anaheim", countryCode: "US", cityId: 3, location: Coordinate(latitude: 10.90, longitude: 18.90), cityCountryCode: "Anaheim, US"
            ),
            City(
                cityName: "Arizona", countryCode: "US", cityId: 4, location: Coordinate(latitude: 10.90, longitude: 18.90), cityCountryCode: "Arizona, US"
            ),
            City(
                cityName: "Sydney", countryCode: "AU", cityId: 5, location: Coordinate(latitude: 10.90, longitude: 18.90), cityCountryCode: "Sydney, AU"
            )
        ]
        return cities
    }
    
    private func createRandomNumericString(length: Int) -> String {
        let letters = "0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
    
    private func createRandomSpecialCharString(length: Int) -> String {
        let passwordRegex = "^[0-9 !\"#$%&()*+,-./:;<=>?@\\[\\\\\\]_{|}~].{8,}$"
        return String((0..<length).map { _ in passwordRegex.randomElement()! })

    }

    func testFilteredList() {
        let filteredCities: [City] = filterModelObj.filterData(searchedText: "A", data: cities)
        XCTAssertTrue(filteredCities.contains {$0.cityName == "Alabama"})
        XCTAssertTrue(filteredCities.contains {$0.cityName == "Albuquerque"})
        XCTAssertTrue(filteredCities.contains {$0.cityName == "Anaheim"})
        XCTAssertTrue(filteredCities.contains {$0.cityName == "Arizona"})
        XCTAssertFalse(filteredCities.contains {$0.cityName == "Sydney"})
    }
    
    func testFilteredListWithInvalidInput() {
        let filteredCities: [City] = filterModelObj.filterData(searchedText: createRandomSpecialCharString(length: 4), data: cities)
        XCTAssertTrue(filteredCities.isEmpty)
    }
    
    func testFilteredListWithRandomCityName() {
        let cityNames = cities.map {$0.cityName}
        let searchedCity  = cityNames.randomElement()
        let filteredCities: [City] = filterModelObj.filterData(searchedText: searchedCity!, data: cities)
        XCTAssertFalse(filteredCities.isEmpty)
    }
    
    func testFilteredListWithEmptyString() {
        let filteredCities: [City] = filterModelObj.filterData(searchedText: "", data: cities)
        XCTAssertTrue(filteredCities.count == cities.count)

    }
}
