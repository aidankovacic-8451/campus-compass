//
//  AvailableFeaturesList.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/14/23.
//

import SwiftUI

struct AvailableFeaturesList: View {
    @State var startingLocation: Bool
    @Binding var fromLocation: String
    @Binding var toLocation: String
    var features: [Feature] = [
        .init(name: "100"),
        .init(name: "309"),
        .init(name: "First Floor Bathrooms")
    ]
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Features")) {
                    ForEach(features, id: \.name) { feature in
                        Button(feature.name) {
                            if startingLocation {
                                fromLocation = feature.name
                            } else {
                                toLocation = feature.name
                            }
                            dismiss()
                        }
                        .foregroundColor(.black)
                    }
                }
            }
            .navigationBarTitle("Available Features")
        }
    }
}

struct AvailableFeaturesList_Previews: PreviewProvider {
    @State static var fromLocation: String = "420"
    @State static var toLocation: String = "1337"
    static var previews: some View {
        AvailableFeaturesList(startingLocation: true, fromLocation: $fromLocation, toLocation: $toLocation)
            .environmentObject(Store())
    }
}

struct Feature: Hashable {
    let name: String
}
