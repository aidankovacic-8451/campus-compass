//
//  CampusCompassApp.swift
//  CampusCompass
//
//  Created by Aidan Kovacic on 6/26/23.
//

import SwiftUI

@main
struct CampusCompassApp: App {
    
    @StateObject var store = Store()
    
    /*let schoolSelection = SchoolSelection()
    let buildingSelection = BuildingSelection()
    let startingLocationSelection = StartingLocationSelection()
    let endingLocationSelection = EndingLocationSelection()
    let accessibilitySettings = AccessibilitySetting()*/
    @StateObject var network = Network()
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environmentObject(store)
                .environmentObject(network)
        }
    }
}
