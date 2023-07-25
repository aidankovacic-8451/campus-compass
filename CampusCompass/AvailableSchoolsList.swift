//
//  AvailableSchoolsList.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/13/23.
//

import SwiftUI

struct AvailableSchoolsList: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var store: Store
    @EnvironmentObject var network: Network
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Schools")) {
                    ForEach(network.schools, id: \.internalName) { school in
                        NavigationLink {
                            BuildingSearchScreen()
                                .onAppear {
                                    store.selectedSchoolName = school.name
                                    store.selectedSchoolInternalName = school.internalName
                                    store.clearCampusAttributes()
                                }
                        } label: {
                            Text(school.name)
                        }
                        
                    }
                }
            }
            .navigationBarTitle("Available Schools")
            .onAppear {
                network.fetchCampuses()
            }
        }
    }
}


struct AvailableSchoolsList_Previews: PreviewProvider {
    static var previews: some View {
        AvailableSchoolsList()
            .environmentObject(Store())

    }
}

