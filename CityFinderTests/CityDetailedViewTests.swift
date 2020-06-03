//
//  CityDetailedViewTests.swift
//  CityFinderTests
//
//  Created by Manali Mogre on 31/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import XCTest
import MapKit
@testable import CityFinder

class CityDetailedViewTests: XCTestCase {
    
    //declaring the ViewController under test as an implicitly unwrapped optional
    var viewControllerUnderTest: CityDetailedViewController!
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "CityDetailedTableViewController") as? CityDetailedViewController
        createSelectedCityModelTestData()
        
        if viewControllerUnderTest != nil {
            viewControllerUnderTest.loadView()
            viewControllerUnderTest.viewDidLoad()
        }
    }
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    func createSelectedCityModelTestData() {
        let city =  City(
            cityName: "Alabama", countryCode: "US", location: Coordinate(latitude: 10.90, longitude: 18.90)
        )
        let cityViewModel  = CityViewModel(city: city)
        viewControllerUnderTest.selectedCityViewModel = cityViewModel
    }
    
    func testViewControllerIsComposedOfMapView() {
        XCTAssertNotNil(viewControllerUnderTest.cityMapView, "ViewController under test is not composed of a MKMapView")
    }
    
    func testControllerAddsAnnotationsToMapView() {
        let annotationsOnMap = self.viewControllerUnderTest.cityMapView.annotations
        XCTAssertGreaterThan(annotationsOnMap.count, 0)
    }
}
