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
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environmentObject(schoolSelection)
            
        }
    }
}
