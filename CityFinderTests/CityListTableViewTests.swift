//
//  CityListTableViewTests.swift
//  CityFinderTests
//
//  Created by Manali Mogre on 29/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import XCTest
@testable import CityFinder

class CityListTableViewTests: XCTestCase {

    var viewControllerUnderTest: CityListTableViewController!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "CityListTableViewController") as? CityListTableViewController
        self.viewControllerUnderTest.loadView()
        //self.viewControllerUnderTest.viewDidLoad()
    }

    override func tearDown() {
        super.tearDown()
        
    }

    func testHasATableView() {
           XCTAssertNotNil(viewControllerUnderTest.tableView)
       }
       
       func testTableViewHasDelegate() {
           XCTAssertNotNil(viewControllerUnderTest.tableView.delegate)
       }
       
       func testTableViewConfromsToTableViewDelegateProtocol() {
           XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
           XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:didSelectRowAt:))))
       }
       
       func testTableViewHasDataSource() {
           XCTAssertNotNil(viewControllerUnderTest.tableView.dataSource)
       }
       
       func testTableViewConformsToTableViewDataSourceProtocol() {
           XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
           XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.numberOfSections(in:))))
           XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
           XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
       }
       
      
}
