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
        .init(name: "Braunstein Hall", internalName: "braunstein"),
        .init(name: "Swift Hall", internalName: "swift"),
        .init(name: "Teachers/Dyer Complex", internalName: "dyer"),
        .init(name: "Tangeman University Center", internalName: "tuc")
    ]
    
    let universityofdayton: [Building] = [
        .init(name: "A Cool Hall", internalName: "udcoolhall"),
        .init(name: "A Big Building", internalName: "udbigbuilding"),
        .init(name: "Some Complex", internalName: "somecomplex"),
        .init(name: "Athletic Center", internalName: "udathletic")
    ]
    
    let miamiuniversity: [Building] = [
        .init(name: "Another Hall", internalName: "muhall"),
        .init(name: "Different Building 1", internalName: "mudb1"),
        .init(name: "Different Building 2", internalName: "mudb2"),
        .init(name: "Food Court", internalName: "mufoodcourt")
    ]
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var store: Store

    var buildings: [Building] {
        switch store.selectedSchoolName {
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
            Text(store.selectedSchoolName)
        }
        
        NavigationStack {
            List {
                Section(header: Text("Buildings")) {
                    ForEach(buildings, id: \.name) { building in
                        NavigationLink {
                            LocationSelectionScreen(buildingName: building.name)
                        } label: {
                            Text(building.name)
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
            .environmentObject(Store())
    }
}

struct Building: Hashable {
    let name: String
    let internalName: String
}
