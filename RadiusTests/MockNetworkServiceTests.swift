//
//  MockNetworkServiceTests.swift
//  RadiusTests
//
//  Created by Kavyashree Hegde on 29/06/23.
//

import XCTest
@testable import Radius

class MockNetworkServiceTests: XCTestCase {
    let mockService = MockNetworkService()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMockNetworkService() {
//        Task {
//            let data = await mockService.sendRequest(endpoint: MockFacilityRequestEndpoint(), responseModel: FacilityResponse.self)
//
//            switch data {
//            case .success(let successResponse):
//                XCTAssertNotNil(successResponse)
//            case .failure(let error):
//               XCTAssertNil(error)
//            }
//        }
    }
    
    func testMockNetworkServiceWithInvalidUrl() {
//        Task {
//            let result = await self.mockService.sendInvalidUrlRequest(endpoint: MockFacilityRequestInvalidUrlEndpoint(), responseModel: FacilityResponse.self)
//            
//            XCTAssertEqual(result, .failure(.invalidURL))
//        }
    }
}
