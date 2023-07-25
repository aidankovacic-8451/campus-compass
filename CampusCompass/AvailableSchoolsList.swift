//
//  AvailableSchoolsList.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/13/23.
//

import SwiftUI

struct AvailableSchoolsList: View {
    var schools: [School] = [
        .init(name: "University of Cincinnati", internalName: "uc"),
        .init(name: "University of Dayton", internalName: "ud"),
        .init(name: "Miami University", internalName: "miamiohio")
    ]
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Schools")) {
                    ForEach(schools, id: \.self) { school in
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
        }
    }
}


struct AvailableSchoolsList_Previews: PreviewProvider {
    static var previews: some View {
        AvailableSchoolsList()
            .environmentObject(Store())

    }
}

struct School: Hashable {
    let name: String
    let internalName: String
}
