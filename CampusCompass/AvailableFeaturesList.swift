//
//  AvailableFeaturesList.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/14/23.
//

import SwiftUI

struct AvailableFeaturesList: View {
    var startingLocation: Bool
    @Binding var fromLocation: String
    @Binding var toLocation: String
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var store: Store
    @EnvironmentObject var network: Network
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Features")) {
                    ForEach(network.features, id: \.self) { feature in
                        if !(feature.contains("stair") || feature.contains("elevator")) {
                            Button(feature) {
                                if startingLocation {
                                    fromLocation = feature
                                } else {
                                    toLocation = feature
                                }
                                dismiss()
                            }
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        }
                    }
                }
            }
            .navigationBarTitle("Available Features")
        }
        .onAppear {
            network.fetchFeatures(building: store.selectedBuildingInternalName)
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
