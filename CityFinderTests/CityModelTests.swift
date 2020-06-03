//
//  CityModelTests.swift
//  CityFinderTests
//
//  Created by Manali Mogre on 28/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import XCTest
@testable import CityFinder

class CityModelTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCityJsonResponse() throws {
        guard
            let path = Bundle.main.path(forResource: Constants.kCitiesJSON, ofType: "json")
            else {
                XCTFail("Missing file: cities.json")
                return
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let response = try JSONDecoder().decode([City].self, from: data)
        XCTAssertNotNil(response)
        XCTAssert((response as Any) is [City])

        let firstCity = response.first
        XCTAssertNotNil(firstCity?.cityName)
        XCTAssertNotNil(firstCity?.countryCode)
        XCTAssertNotNil(firstCity?.location.latitude)
        XCTAssertNotNil(firstCity?.location.longitude)
        
        XCTAssert((firstCity?.cityName as Any) is String)
        XCTAssert((firstCity?.countryCode as Any) is String)
        XCTAssert((firstCity?.location.latitude as Any) is Double)
        XCTAssert((firstCity?.location.longitude as Any) is Double)

    }
}
