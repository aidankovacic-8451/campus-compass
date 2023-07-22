//
//  AvailableBuildingsList.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/14/23.
//

import SwiftUI

struct AvailableBuildingsList: View {
    var buildings: [Building] = [
        .init(name: "Swift Hall", internalName: "swift"),
        .init(name: "Teachers/Dyer", internalName: "dyer"),
        .init(name: "Tangeman University Center", internalName: "tuc")
    ]
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var schoolSelection: SchoolSelection
    @EnvironmentObject var buildingSelection: BuildingSelection
    @EnvironmentObject var startingLocationSelection: StartingLocationSelection
    @EnvironmentObject var endingLocationSelection: EndingLocationSelection
    @EnvironmentObject var accessibilitySettings: AccessibilitySetting
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Buildings")) {
                    ForEach(buildings, id: \.name) { building in
                        NavigationLink(destination: LocationSelectionScreen()) {
                            Text(building.name)
                        }
                        .onTapGesture {
                            buildingSelection.selectedBuildingName = building.name
                            buildingSelection.selectedBuildingInternalName = building.internalName
                        }
                    }
                }
            }
            .navigationBarTitle("Available Buildings")
        }
    }
}

struct AvailableBuildingsList_Previews: PreviewProvider {
    static var previews: some View {
        AvailableBuildingsList()
            .environmentObject(SchoolSelection())
            .environmentObject(BuildingSelection())
            .environmentObject(StartingLocationSelection())
            .environmentObject(EndingLocationSelection())
            .environmentObject(AccessibilitySetting())
    }
}

struct Building: Hashable {
    let name: String
    let internalName: String
}
