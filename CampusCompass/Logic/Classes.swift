//
//  BuildingSelection.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/14/23.
//

import SwiftUI
import Foundation
import Combine

class Store: ObservableObject {
    @Published var selectedSchoolName: String = ""
    @Published var selectedSchoolInternalName: String = ""
    
    @Published var selectedBuildingName: String = ""
    @Published var selectedBuildingInternalName: String = ""
    
    @Published var enableAccessibilityMode = false
        
    func clearCampusAttributes() {
        selectedBuildingName = ""
        selectedBuildingInternalName = ""
    }
    
}

struct School: Hashable {
    let name: String
    let internalName: String
}

struct Building: Hashable {
    let name: String
    let internalName: String
}

struct Feature: Hashable {
    var name: String = ""
    var type: FeatureType = .null
    
    func getFriendlyName() -> String {
        let cleanName = name.replacingOccurrences(of: "stair ", with: "")
                            .replacingOccurrences(of: "elevator ", with: "")
        return "\(self.type.properString) \(cleanName)"
    }
}

enum FeatureType: String {
    case classroom = "classroom"
    case bathroom = "bathroom"
    case stairs = "stairs"
    case elevator = "elevator"
    case null = ""
    var properString: String {
        switch self {
        case .classroom:
            return "Classroom"
        case .bathroom:
            return "Bathroom"
        case .stairs:
            return "Stairwell"
        case .elevator:
            return "Elevator"
        case .null:
            return ""
        }
    }
}
