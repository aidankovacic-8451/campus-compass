//
//  AvailableSchoolsList.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/13/23.
//

import SwiftUI

struct AvailableSchoolsList: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var store: Store
    @EnvironmentObject var network: Network
    
    @State var errorState: Bool = false
    
    var body: some View {
        NavigationStack {
            NavigationStack{
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
                        Section(header: Text("Available Schools")) {
                            ForEach(network.schools, id: \.internalName) { school in
                                NavigationLink {
                                    BuildingSearchScreen()
                                        .onAppear {
                                            store.selectedSchoolName = school.name
                                            store.selectedSchoolInternalName = school.internalName
                                            store.clearCampusAttributes()
                                        }
                                } label: {
                                    Text(school.name)
                                }
                                
                            }
                        }
                    }
                    .task {
                        if network.schools.isEmpty {
                            await network.fetchCampuses()
                        }
                    }
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
                    await network.fetchCampuses()
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



struct AvailableSchoolsList_Previews: PreviewProvider {
    static var previews: some View {
        AvailableSchoolsList()
            .environmentObject(Store())
            .environmentObject(Network())
    }
}

