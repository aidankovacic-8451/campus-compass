//
//  AvailableSchoolsList.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/13/23.
//

import SwiftUI

struct AvailableSchoolsList: View {
    var schools: [School] = [
        .init(name: "University of Cincinnati"),
        .init(name: "University of Dayton"),
        .init(name: "Miami University")
    ]
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var schoolSelection: SchoolSelection
    
    var body: some View {
        NavigationStack {
                List {
                    Section(header: Text("Schools")) {
                        ForEach(schools, id: \.name) { school in
                            NavigationLink(destination: BuildingSearchScreen()) {
                                Text(school.name)
                            }
                            .onTapGesture {
                                schoolSelection.selectedSchoolName = school.name
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
            .environmentObject(SchoolSelection())
    }
}

struct School: Hashable {
    let name: String
}
