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
    @Published var selectedStartingLocationName: String = ""
    @Published var selectedEndingLocationName: String = ""
    @Published var enableAccessibilityMode = false
}
