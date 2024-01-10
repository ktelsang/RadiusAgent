//
//  MockJSON.swift
//  RadiusTests
//
//  Created by Kavyashree Hegde on 29/06/23.
//

import Foundation
@testable import Radius

let jsonString = """
{
  "facilities": [
    {
      "facility_id": "1",
      "name": "Property Type",
      "options": [
        {
          "name": "Apartment",
          "icon": "apartment",
          "id": "1"
        },
        {
          "name": "Condo",
          "icon": "condo",
          "id": "2"
        },
        {
          "name": "Boat House",
          "icon": "boat",
          "id": "3"
        },
        {
          "name": "Land",
          "icon": "land",
          "id": "4"
        }
      ]
    },
    {
      "facility_id": "2",
      "name": "Number of Rooms",
      "options": [
        {
          "name": "1 to 3 Rooms",
          "icon": "rooms",
          "id": "6"
        },
        {
          "name": "No Rooms",
          "icon": "no-room",
          "id": "7"
        }
      ]
    },
    {
      "facility_id": "3",
      "name": "Other facilities",
      "options": [
        {
          "name": "Swimming Pool",
          "icon": "swimming",
          "id": "10"
        },
        {
          "name": "Garden Area",
          "icon": "garden",
          "id": "11"
        },
        {
          "name": "Garage",
          "icon": "garage",
          "id": "12"
        }
      ]
    }
  ],
  "exclusions": [
    [
      {
        "facility_id": "1",
        "options_id": "4"
      },
      {
        "facility_id": "2",
        "options_id": "6"
      }
    ],
    [
      {
        "facility_id": "1",
        "options_id": "3"
      },
      {
        "facility_id": "3",
        "options_id": "12"
      }
    ],
    [
      {
        "facility_id": "2",
        "options_id": "7"
      },
      {
        "facility_id": "3",
        "options_id": "12"
      }
    ]
  ]
}
"""

class MockJSON {
    func getMockObject<T: Codable>() -> T {
        let jsonData = Data(jsonString.utf8)
        let mockFacilityObject = try! JSONDecoder().decode(T.self, from: jsonData)
        return mockFacilityObject
    }
}

struct MockFacilityRequestEndpoint: Endpoint {
    var header: [String : String]?
    
    var body: [String : String]?
    
    var path: String {
        "/iranjith4/ad-assignment/db"
    }
    var method: RequestMethod {
        .get
    }
}

struct MockFacilityRequestInvalidUrlEndpoint: Endpoint {
    var header: [String : String]?
    
    var body: [String : String]?
    
    var path: String {
        "/iranjith4/ad-assignment/db/1234"
    }
    var method: RequestMethod {
        .get
    }
}
