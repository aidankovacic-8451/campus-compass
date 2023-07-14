//
//  SwiftUIView.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/13/23.
//

import SwiftUI

struct BuildingSearchScreen: View {

            
    @State private var enableAccessibilityRouting = true
    @State private var path = NavigationPath()
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var schoolSelection: SchoolSelection
    
            var body: some View {
                
                //This NavStack allows buttons on the homescreen to be functional
                NavigationStack{
                //This VStack aligns our homescreen UI with buttons and logic
                    VStack{
                        
                        //This HStack aligns the top most part of the home screen
                        HStack {
                            
                            Image(systemName:"house.fill")
                                .padding(.leading, 20)
                                .foregroundColor(Color.accentColor)
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
                        
                        Text("Selected School: \(schoolSelection.selectedSchoolName)")
                            .foregroundColor(Color.black)
                        
                        
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
                                    Text("Find your building")
                                        .foregroundColor(Color.white)
                                        .fontWeight(.bold)
                                    }
                                }
                            }
                        .padding(.top, 260.0)
                        
                        Spacer()
                        
                        //This toggle will enable and disable accessibility mode
                        Toggle("Accessibility Mode", isOn: $enableAccessibilityRouting)
                            .padding(.horizontal, 85)
                            .padding (.bottom, 50)
                            .fontWeight(.bold)
                            .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                        
                        if enableAccessibilityRouting {
                            Text("this will find accessbility routes")
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingSearchScreen()
            .environmentObject(SchoolSelection())
    }
}
