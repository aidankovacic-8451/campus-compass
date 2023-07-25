//
//  AvailableBuildingsList.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/14/23.
//

import SwiftUI
import Foundation

struct AvailableBuildingsList: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var store: Store
    @EnvironmentObject var network: Network
  
    var body: some View {
        
        /*VStack{
            Text("Buildings at \(store.selectedSchoolName)")
        }
        */
        NavigationStack {
            List {
                Section(header: Text("Buildings")) {
                    ForEach(network.buildings, id: \.internalName) { building in
                        NavigationLink {
                            LocationSelectionScreen()
                                .onAppear {
                                    store.selectedBuildingName = building.name
                                    store.selectedBuildingInternalName = building.internalName
                                }
                        } label: {
                            Text(building.name)
                        }
                        
                    }
                }
            }
            .navigationBarTitle("Available Buildings")
            .onAppear {
                network.fetchBuildings(campus: store.selectedSchoolInternalName)
            }
        }
    }
}

struct AvailableBuildingsList_Previews: PreviewProvider {
    static var previews: some View {
        AvailableBuildingsList()
            .environmentObject(Store())
    }
}
