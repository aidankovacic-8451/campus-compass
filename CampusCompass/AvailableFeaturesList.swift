//
//  AvailableFeaturesList.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/14/23.
//

import SwiftUI

struct AvailableFeaturesList: View {
    var features: [Feature] = [
        .init(name: "Room 620"),
        .init(name: "Quadrangle Entrance"),
        .init(name: "First Floor Bathrooms")
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
                Section(header: Text("Features")) {
                    ForEach(features, id: \.name) { feature in
                        NavigationLink(destination: LocationSelectionScreen()) {
                            Text(feature.name)
                        }
                        .simultaneousGesture(TapGesture()
                            .onEnded(){
                                startingLocationSelection.selectedStartingLocationName = feature.name
                            })
                    }
                }
            }
            .navigationBarTitle("Available Features")
        }
    }
}

struct AvailableFeaturesList_Previews: PreviewProvider {
    static var previews: some View {
        AvailableFeaturesList()
            .environmentObject(SchoolSelection())
            .environmentObject(BuildingSelection())
            .environmentObject(StartingLocationSelection())
            .environmentObject(EndingLocationSelection())
            .environmentObject(AccessibilitySetting())
    }
}

struct Feature: Hashable {
    let name: String
}
