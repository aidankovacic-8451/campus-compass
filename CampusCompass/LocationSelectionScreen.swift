//
//  LocationSelectionScreen.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/14/23.
//

import SwiftUI

struct LocationSelectionScreen: View {
    private var buildingName: String
    @State private var fromLocation: String = ""
    @State private var toLocation: String = ""
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var store: Store
    
    init(buildingName: String) {
        self.buildingName = buildingName
    }
    
    var body: some View {
        
        //This NavStack allows buttons on the homescreen to be functional
        NavigationStack{
            //This VStack aligns our homescreen UI with buttons and logic
            VStack{
                
                //This HStack aligns the top most part of the home screen
                HStack {
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "arrowshape.backward")
                            .foregroundColor(.accentColor)
                            .padding(.leading, 20)
                            .bold()
                    })
                    Spacer()
                    
                    Text("CampusCompass")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                        .foregroundColor(Color.accentColor)
                    
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
               
                VStack{
                    HStack{
                        Text("Selected School:")
                            .font(.system(size: 18))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .padding(.leading, 15)
                            .padding(.top, 10)
                            .padding(.bottom, 6)
                        Spacer()
                    }
                    HStack{
                        Text(" \(store.selectedSchoolName)")
                            .font(.system(size: 30))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.accentColor)
                            .padding(.leading, 15)
                        Spacer()
                    }
                    HStack{
                        Text("Selected Building:")
                            .font(.system(size: 18))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .padding(.leading, 15)
                            .padding(.bottom, 6)

                        Spacer()
                    }
                    HStack{
                        Text(" \(store.selectedBuildingName)")
                            .font(.system(size: 30))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.accentColor)
                            .padding(.leading, 15)

                        Spacer()
                    }
                    HStack{
                        Text("Selected Starting Location:")
                            .font(.system(size: 18))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .padding(.leading, 15)
                            .padding(.bottom, 6)

                        Spacer()
                    }
                    HStack{
                        Text(" \(store.selectedStartingLocationName)")
                            .font(.system(size: 30))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.accentColor)
                            .padding(.leading, 15)
                        
                        Spacer()
                    }
                    HStack{
                        Text("Selected Destination:")
                            .font(.system(size: 18))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .padding(.leading, 15)
                            .padding(.bottom, 6)
                        Spacer()
                    }
                    HStack{
                        Text(" \(store.selectedEndingLocationName)")
                            .font(.system(size: 30))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.accentColor)
                            .padding(.leading, 15)
                        
                        Spacer()
                    }
                }
                // Jank that allows us to change env variables to the State of this
                .onAppear {
                    store.selectedBuildingName = buildingName
                    store.selectedBuildingInternalName = "braunstein"
                }
                .onChange(of: fromLocation) { newValue in
                    store.selectedStartingLocationName = newValue
                }
                .onChange(of: toLocation) { newValue in
                    store.selectedEndingLocationName = newValue
                }
                
                
                Spacer()
                
                HStack{
                    //This link sends the user to the list of available schools
                    NavigationLink(destination: AvailableFeaturesList(startingLocation: true, fromLocation: $fromLocation, toLocation: $toLocation)){
                        Image("locationSelectButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120.0, height: 120.0)
                            .padding(.bottom, 15)
                    }
                    
                    //This link sends the user to the list of available schools
                    NavigationLink(destination: AvailableFeaturesList(startingLocation: false, fromLocation: $fromLocation, toLocation: $toLocation)){
                        Image("destinationSelectButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120.0, height: 120.0)
                            .padding(.bottom, 15)
                            .padding(.leading, 30)
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: RouteView()){
                    ZStack{
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 190.0, height: 70)
                            .foregroundColor(.accentColor)
                        Text("Get Your Route")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                //This toggle will enable and disable accessibility mode
                Toggle("Accessibility Mode", isOn: $store.enableAccessibilityMode)
                    .padding(.horizontal, 85)
                    //.padding (.bottom, 10)
                    .fontWeight(.bold)
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct LocationSelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        LocationSelectionScreen(buildingName: "UC")
            .environmentObject(Store())
    }
}
