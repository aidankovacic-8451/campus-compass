//
//  LocationSelectionScreen.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/14/23.
//

import SwiftUI

struct LocationSelectionScreen: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var store: Store
    @EnvironmentObject var network: Network
    @State private var fromLocation: Feature = Feature()
    @State private var toLocation: Feature = Feature()
    
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
                        Text(" \(store.selectedSchoolName)")
                            .font(.system(size: 30))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.accentColor)
                            .padding(.leading, 15)
                            .padding(.bottom, 4)

                        Spacer()
                    }
                    HStack{
                        Text("Selected Building:")
                            .font(.system(size: 18))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .padding(.leading, 15)

                        Spacer()
                    }
                    HStack{
                        Text(" \(store.selectedBuildingName)")
                            .font(.system(size: 30))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.accentColor)
                            .padding(.leading, 15)
                            .padding(.bottom, 4)


                        Spacer()
                    }
                    HStack{
                        Text("Selected Starting Location:")
                            .font(.system(size: 18))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .padding(.leading, 15)

                        Spacer()
                    }
                    HStack{
                        Text(" \(fromLocation.getFriendlyName())")
                            .font(.system(size: 30))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.accentColor)
                            .padding(.leading, 15)
                            .padding(.bottom, 4)

                        Spacer()
                    }
                    HStack{
                        Text("Selected Destination:")
                            .font(.system(size: 18))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .padding(.leading, 15)
                        Spacer()
                    }
                    HStack{
                        Text(" \(toLocation.getFriendlyName())")
                            .font(.system(size: 30))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.accentColor)
                            .padding(.leading, 15)
                            .padding(.bottom, 4)
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
                HStack{
                    //This link sends the user to the list of available features
                    NavigationLink(destination: AvailableFeaturesList(startingLocation: true, fromLocation: $fromLocation, toLocation: $toLocation)){
                        Image("locationSelectButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120.0, height: 120.0)
                            .padding(.bottom, 15)
                    }
                    
                    //This link sends the user to the list of available features
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
                
                // Only allows route navigation button to be pressed if both starting and ending location are selected.
                RouteButtonView(fromLocation: $fromLocation, toLocation: $toLocation, ready: (fromLocation.type != .null && toLocation.type != .null))
                
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
        // If we change one of the locations, uncache the route
        .onChange(of: fromLocation) { _ in
            network.route = []
        }
        .onChange(of: toLocation) { _ in
            network.route = []
        }
        .onChange(of: store.selectedBuildingInternalName) { _ in
            network.route = []
            network.clearFeatureCache()
        }
    }
}

struct RouteButtonView: View {
    @Binding var fromLocation: Feature
    @Binding var toLocation: Feature
    let ready: Bool
    
    var body: some View {
        // Only allows navigation to route page when ready
        if ready {
            NavigationLink(destination: RouteView(fromLocation: $fromLocation, toLocation: $toLocation)){
                ZStack{
                    RoundedRectangle(cornerRadius: 7)
                        .frame(width: 190.0, height: 70)
                        .foregroundColor(.accentColor)
                    Text("Get Your Route")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
        } else {
            ZStack{
                RoundedRectangle(cornerRadius: 7)
                    .frame(width: 190.0, height: 70)
                    .foregroundColor(.gray)
                Text("Get Your Route")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }
}

struct LocationSelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        LocationSelectionScreen()
            .environmentObject(Store())
    }
}
