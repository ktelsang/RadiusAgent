//
//  Endpoints.swift
//  Radius
//
//  Created by Kavyashree Hegde on 28/06/23.
//

import Foundation

struct FacilityRequestEndpoint: Endpoint {
    var header: [String : String]?
    
    var body: [String : String]?
    
    var path: String {
        "/iranjith4/ad-assignment/db"
    }
    var method: RequestMethod {
        .get
    }
}
