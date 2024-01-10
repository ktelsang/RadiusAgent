//
//  RadiusTests.swift
//  RadiusTests
//
//  Created by Kavyashree Hegde on 29/06/23.
//

import XCTest
@testable import Radius

final class RadiusTests: XCTestCase {
    var viewModel: FacilityViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = FacilityViewModel(facilityData: MockJSON().getMockObject())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testSectionCount() {
        let sectionCount = viewModel?.getSectionCount()
        XCTAssertEqual(sectionCount, 3, "Section count not matching")
    }
    
    func testRowCount() {
        var rowCount = viewModel?.getRowsCount(for: 0)
        XCTAssertEqual(rowCount, 4, "Row count not matching")
        
        rowCount = viewModel?.getRowsCount(for: 1)
        XCTAssertEqual(rowCount, 2, "Row count not matching")
        
        rowCount = viewModel?.getRowsCount(for: 2)
        XCTAssertEqual(rowCount, 3, "Row count not matching")
    }
    
    func testExcludeOptionsForMatchingIds() {
        var excludedData = viewModel?.getExcludedOptionFor(facilityId: "1", optionId: "4")
        
        XCTAssertEqual(try XCTUnwrap(excludedData?.facilityId), "2", "Excluded facility id not matching")
        XCTAssertEqual(try XCTUnwrap(excludedData?.optionId), "6", "Excluded option id not matching")
        
        excludedData = viewModel?.getExcludedOptionFor(facilityId: "1", optionId: "3")
        
        XCTAssertEqual(try XCTUnwrap(excludedData?.facilityId), "3", "Excluded facility id not matching")
        XCTAssertEqual(try XCTUnwrap(excludedData?.optionId), "12", "Excluded option id not matching")
        
        excludedData = viewModel?.getExcludedOptionFor(facilityId: "2", optionId: "7")
        
        XCTAssertEqual(try XCTUnwrap(excludedData?.facilityId), "3", "Excluded facility id not matching")
        XCTAssertEqual(try XCTUnwrap(excludedData?.optionId), "12", "Excluded option id not matching")
    }
    
    func testExcludeOptionsForNotMatchingIds() {
        let excludedData = viewModel?.getExcludedOptionFor(facilityId: "1", optionId: "2")
        
        XCTAssertEqual(excludedData?.facilityId, nil, "Excluded facility id not matching")
        XCTAssertEqual(excludedData?.optionId, nil, "Excluded option id not matching")
    }
    
    func testExcludeOptionsForNilIds() {
        let excludedData = viewModel?.getExcludedOptionFor(facilityId: nil, optionId: nil)
        
        XCTAssertEqual(excludedData?.facilityId, nil, "Excluded facility id not nil")
        XCTAssertEqual(excludedData?.optionId, nil, "Excluded option id not nil")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
