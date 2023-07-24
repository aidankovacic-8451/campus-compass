//
//  BuildingSelection.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/14/23.
//

import SwiftUI
import Foundation
import Combine

class SchoolSelection: ObservableObject {
    @Published var selectedSchoolName: String = ""
}

class BuildingSelection: ObservableObject {
    @Published var selectedBuildingName: String = ""
    @Published var selectedBuildingInternalName: String = ""
}

class StartingLocationSelection: ObservableObject {
    @Published var selectedStartingLocationName: String = ""
}

class EndingLocationSelection: ObservableObject {
    @Published var selectedEndingLocationName: String = ""
}

class AccessibilitySetting: ObservableObject {
    @Published var enableAccessibilityMode = false
}
