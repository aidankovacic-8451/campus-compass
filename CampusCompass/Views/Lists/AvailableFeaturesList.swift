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
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var store: Store
    @EnvironmentObject var network: Network
    
    @State var errorState: Bool = false
    
    var body: some View {
        NavigationStack {
            //This VStack aligns ourheader with buttons and logic
            VStack{
                
                //This HStack aligns the top most part of the screen
                HStack {
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Label("", systemImage: "arrowshape.backward")
                            .foregroundColor(.accentColor)
                            .padding(.leading, 20)
                            .bold()
                    })
                    
                    Spacer()
                    
                    Text("CampusCompass")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                        .foregroundColor(Color.accentColor)
                        .padding(.trailing)

                    Spacer()
                    
                    //This link enables us to go to the settings screen
                    NavigationLink(destination: SettingsScreen()){
                        Image(systemName:"questionmark")
                            .padding(.trailing, 20)
                            .bold()
                    }
                }
                
                Divider()
                    .frame(height:3)
                    .overlay(Color.black)
                    .shadow(color: Color.black, radius: 3, x:0, y: 4)
                List {
                    Section(header: Text("Available Features")) {
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
            }
            .task {
                if network.features.isEmpty {
                    await network.fetchFeatures(building: store.selectedBuildingInternalName)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: network.loadError) { newValue in
            self.errorState = newValue != nil
        }
        // Error handling
        .alert("Error", isPresented: $errorState, presenting: network.loadError) { error in
            Button {
                Task {
                    await network.fetchFeatures(building: store.selectedBuildingInternalName)
                    // Set it to nil so that this will reappear if the error happens again
                    network.loadError = nil
                }
            } label: {
                Text("Try Again")
            }
            Button {
                network.loadError = nil
                dismiss()
            } label: {
                Text("OK")
            }
        } message: { error in
            Text(error.description)
        }
    }
}



struct AvailableFeaturesList_Previews: PreviewProvider {
    @State static var fromLocation: String = "420"
    @State static var toLocation: String = "1337"
    static var previews: some View {
        AvailableFeaturesList(startingLocation: true, fromLocation: $fromLocation, toLocation: $toLocation)
            .environmentObject(Store())
            .environmentObject(Network())

    }
}

struct Feature: Hashable {
    let name: String
}
