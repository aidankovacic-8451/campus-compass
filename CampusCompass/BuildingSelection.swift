//
//  BuildingSelection.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/14/23.
//

import SwiftUI

class BuildingSelection: ObservableObject {
    @Published var selectedBuildingName: String = ""
    @Published var selectedBuildingInternalName: String = ""
}
