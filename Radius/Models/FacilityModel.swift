//
//  FacilityModel.swift
//  Radius
//
//  Created by Kavyashree Hegde on 28/06/23.
//

import Foundation

// MARK: - Base response
struct FacilityResponse: Codable {
    var facilities: [Facility]
    let exclusions: [[Exclusion]]
}

// MARK: - Exclusion
struct Exclusion: Codable {
    let facility_id, options_id: String
}

// MARK: - Facility
struct Facility: Codable {
    let facility_id: String
    let name: String
    var options: [Option]
}

// MARK: - Option
struct Option: Codable {
    let name, icon, id: String
    var selected: Bool? = false
}
