//
//  SwiftUIView.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/13/23.
//

import SwiftUI

struct BuildingSearchScreen: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var store: Store
    @EnvironmentObject var network: Network
    
    var body: some View {
        
        //This NavStack allows buttons on the homescreen to be functional
        NavigationStack{
            //This VStack aligns our buiding search screen UI with buttons and logic
            VStack{
                
                //This HStack aligns the top most part of the home screen
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
                
                //Spacer()
                
                VStack{
                    HStack{
                        Text("Selected School:")
                            .font(.system(size: 18))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .padding(.leading, 15)
                            .padding(.top, 10)
                        Spacer()
                    }
                    HStack{
                        Text("\(store.selectedSchoolName)")
                            .font(.system(size: 33))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.accentColor)
                            .padding(.leading, 15)
                            .padding(.bottom, 4)

                        //Spacer()
                    }
                }
                
                //This link sends the user to the list of available schools
                NavigationLink(destination: AvailableBuildingsList()){
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
                .position(x:200, y:420)
                
                Spacer()
                
                //This toggle will enable and disable accessibility mode
                Toggle("Accessibility Mode", isOn: $store.enableAccessibilityMode)
                    .padding(.horizontal, 85)
                    .padding (.bottom, 30)
                    .fontWeight(.bold)
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            }
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: store.selectedSchoolInternalName) { _ in
            network.clearBuildingCache()
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingSearchScreen()
            .environmentObject(Store())
    }
}
