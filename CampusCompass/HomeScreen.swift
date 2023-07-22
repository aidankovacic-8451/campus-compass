//
//  HomeScreen.swift
//  CampusCompass
//
//  Created by Aidan Kovacic on 6/26/23.
//

import SwiftUI



struct HomeScreen: View {
    
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
                    
                    Image(systemName: "house.fill")
                        .hidden()
                    
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
                
                Spacer()
                
                //This link sends the user to the list of available schools
                NavigationLink(destination: AvailableSchoolsList()){
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.accentColor)
                            .frame(width:200, height: 150)
                        VStack{
                            Image(systemName: "magnifyingglass")
                                .resizable(resizingMode: .stretch)
                                .foregroundColor(Color.white)
                                .frame(width: 50.0, height: 50.0)
                                .padding(.bottom, 15)
                            Text("Find your school")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                            }
                        }
                    }
                .position(x:200, y:470)
                
                Spacer()
                
                //This toggle will enable and disable accessibility mode
                Toggle("Accessibility Mode", isOn: $accessibilitySettings.enableAccessibilityMode)
                    .padding(.horizontal, 85)
                    .padding (.bottom, 50)
                    .fontWeight(.bold)
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(SchoolSelection())
            .environmentObject(BuildingSelection())
            .environmentObject(StartingLocationSelection())
            .environmentObject(EndingLocationSelection())
            .environmentObject(AccessibilitySetting())
            .environmentObject(Network())
    }
}


