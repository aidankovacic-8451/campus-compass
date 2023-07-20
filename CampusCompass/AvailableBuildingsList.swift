//
//  AvailableBuildingsList.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/14/23.
//

import SwiftUI
import Foundation

struct AvailableBuildingsList: View {
    
    
    
    let universityofcincinnati: [Building] = [
        .init(name: "Braunstein Hall"),
        .init(name: "Swift Hall"),
        .init(name: "Teachers/Dyer Complex"),
        .init(name: "Tangeman University Center")
    ]
    
    let universityofdayton: [Building] = [
        .init(name: "A Cool Hall"),
        .init(name: "A Big Building"),
        .init(name: "Some Complex"),
        .init(name: "Athletic Center")
    ]
    
    let miamiuniversity: [Building] = [
        .init(name: "Another Hall"),
        .init(name: "Different Building 1"),
        .init(name: "Different Building 2"),
        .init(name: "Food Court")
    ]
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var schoolSelection: SchoolSelection
    @EnvironmentObject var buildingSelection: BuildingSelection
    @EnvironmentObject var startingLocationSelection: StartingLocationSelection
    @EnvironmentObject var endingLocationSelection: EndingLocationSelection
    @EnvironmentObject var accessibilitySettings: AccessibilitySetting

    var buildings: [Building] {
        switch schoolSelection.selectedSchoolName {
        case "University of Cincinnati":
            return universityofcincinnati
        case "University of Dayton":
            return universityofdayton
        case "Miami University":
            return miamiuniversity
        default:
            return []
        }
    }
    
  
    var body: some View {
        
        VStack{
            Text(schoolSelection.selectedSchoolName)
        }
        
        NavigationStack {
            List {
                Section(header: Text("Buildings")) {
                    ForEach(buildings, id: \.name) { building in
                        NavigationLink(destination: LocationSelectionScreen()) {
                            Text(building.name)
                        }
                        .simultaneousGesture(TapGesture()
                            .onEnded(){
                                buildingSelection.selectedBuildingName = building.name
                            })
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
}
