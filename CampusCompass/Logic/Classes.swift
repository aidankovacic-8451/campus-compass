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
