//
//  LocationSelectionScreen.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/14/23.
//

import SwiftUI

struct LocationSelectionScreen: View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var schoolSelection: SchoolSelection
    @EnvironmentObject var buildingSelection: BuildingSelection
    @EnvironmentObject var startingLocationSelection: StartingLocationSelection
    @EnvironmentObject var endingLocationSelection: EndingLocationSelection
    @EnvironmentObject var accessibilitySettings: AccessibilitySetting
    
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
                        Spacer()
                    }
                    HStack{
                        Text(" \(schoolSelection.selectedSchoolName)")
                            .font(.system(size: 33))
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
                        Spacer()
                    }
                    HStack{
                        Text(" \(buildingSelection.selectedBuildingName)")
                            .font(.system(size: 33))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.accentColor)
                            .padding(.leading, 15)
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
                VStack{
                    //This link sends the user to the list of available schools
                    NavigationLink(destination: AvailableFeaturesList()){
                        Image("locationSelectButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150.0, height: 150.0)
                            .padding(.bottom, 15)
                        
                    }
                    .padding(.top, 60)
                    
                    
                    //This link sends the user to the list of available schools
                    NavigationLink(destination: AvailableFeaturesList()){
                        Image("destinationSelectButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150.0, height: 150.0)
                            .padding(.bottom, 15)
                        
                    }
                }
                
                
                Spacer()
                
                //This toggle will enable and disable accessibility mode
                Toggle("Accessibility Mode", isOn: $accessibilitySettings.enableAccessibilityMode)
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
        LocationSelectionScreen()
            .environmentObject(SchoolSelection())
            .environmentObject(BuildingSelection())
            .environmentObject(StartingLocationSelection())
            .environmentObject(EndingLocationSelection())
            .environmentObject(AccessibilitySetting())
    }
}
