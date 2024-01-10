//
//  FacilityViewModel.swift
//  Radius
//
//  Created by Kavyashree Hegde on 28/06/23.
//

import Foundation

enum FacilityType: String {
    case propertyTye = "1"
    case numberOfRooms = "2"
    case otherFacilities = "3"
}

class FacilityViewModel {
    var facilityData: FacilityResponse
    var facilities: [Facility] = []
    var currentFacilities: [Facility] = []
    var exclusions: [[Exclusion]] = []
    
    init(facilityData: FacilityResponse) {
        self.facilityData = facilityData
        
        facilities = facilityData.facilities
        currentFacilities = facilities
        exclusions = facilityData.exclusions
    }
    
    func getSectionCount() -> Int {
        currentFacilities.count
    }
    
    func getSectionHeaderTitle(for section: Int) -> String {
        currentFacilities[section].name
    }
    
    func getRowsCount(for section: Int) -> Int {
        currentFacilities[section].options.count
    }
    
    func getFacilities(for section: Int) -> Facility {
        currentFacilities[section]
    }
    
    func clearSelectionForPropertyType() {
        if let options = facilities.first?.options {
            for (index,_) in options.enumerated() {
                facilities[0].options[index].selected = false
            }
        }
    }
    
    func updateSelectionForPropertyTypeFor(section: Int, row: Int) {
        currentFacilities = facilities
        currentFacilities[section].options[row].selected = true
        facilities[section].options[row].selected = true
    }
    
    private func updateFacilityMatchingId(facilityId: String, facility: Facility) {
        for (index, data) in facilities.enumerated() where data.facility_id == facilityId {
            currentFacilities[index] = facility
        }
    }
    
    func updateDataSourceFor(facilityId: String?, optionId: String?) {
        let excludedData = getExcludedOptionFor(facilityId: facilityId, optionId: optionId)
        
        guard excludedData.facilityId != nil && excludedData.optionId != nil else {
            return
        }
        
        for var facility in facilities where facility.facility_id == excludedData.facilityId {
            for (optionIndex, option) in facility.options.enumerated() where option.id == excludedData.optionId {
                facility.options.remove(at: optionIndex)
            }
            updateFacilityMatchingId(facilityId: excludedData.facilityId ?? "0", facility: facility)
        }
    }
    
    func getExcludedOptionFor(facilityId: String?, optionId: String?) -> (facilityId: String?, optionId: String?) {
        var excludedFacilityId: String?
        var excludedOptionId: String?
        
        guard let facilityId = facilityId, let optionId = optionId else {
            print("Please provide facility_id & option_id to exclude")
            return (nil, nil)
        }
        
        for exclusionsData in exclusions {
            let exclusionMatch = exclusionsData.first
            if exclusionMatch?.facility_id == facilityId && exclusionMatch?.options_id == optionId {
                excludedFacilityId = exclusionsData.last?.facility_id
                excludedOptionId = exclusionsData.last?.options_id
                break
            }
        }
        
        return (excludedFacilityId, excludedOptionId)
    }
}

