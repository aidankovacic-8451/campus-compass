//
//  CampusCompassApp.swift
//  CampusCompass
//
//  Created by Aidan Kovacic on 6/26/23.
//

import SwiftUI

@main
struct CampusCompassApp: App {
    @StateObject var schoolSelection = SchoolSelection()
    @StateObject var buildingSelection = BuildingSelection()
    @StateObject var startingLocationSelection = StartingLocationSelection()
    @StateObject var endingLocationSelection = EndingLocationSelection()
    @StateObject private var accessibilitySettings = AccessibilitySetting()
    @StateObject var network = Network()
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environmentObject(schoolSelection)
                .environmentObject(buildingSelection)
                .environmentObject(startingLocationSelection)
                .environmentObject(endingLocationSelection)
                .environmentObject(accessibilitySettings)
                .environmentObject(network)
        }
    }
}
