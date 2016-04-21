//
//  WeatherDemoTests.swift
//  WeatherDemoTests
//
//  Created by Alexander Song on 4/19/16.
//  Copyright © 2016 LexCorp. All rights reserved.
//

import XCTest
@testable import WeatherDemo
import WeatherDemo
import CoreLocation

class WeatherDemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func fetchLocationsFromDBAfterViewDidLoad() {
        
        class FauxCoreDataHelper: CoreDataHelper {
        
            var fetchedLocationsFromDBWasCalled = false
            
            private func fetchedLocationsFromDB() {
                fetchedLocationsFromDBWasCalled = true
            }
            
        }
    
        let chooseLocationVC = ChooseLocationViewController()
        
        chooseLocationVC.coreDataHelper = FauxCoreDataHelper()
        
        chooseLocationVC.viewDidLoad()
        
        XCTAssertTrue((chooseLocationVC.coreDataHelper as! FauxCoreDataHelper).fetchedLocationsFromDBWasCalled, "fetchLocationsFromDB not called")
        
    }
    
}
