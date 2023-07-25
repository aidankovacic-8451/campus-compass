//
//  CompletionScreen.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/24/23.
//

import SwiftUI

struct CompletionScreen: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var rating: Int = 0 // Track the selected rating

    var body: some View {
        NavigationStack{
            //This VStack aligns our homescreen UI with buttons and logic
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
                
                Text("You have reached your destination!")
                    .foregroundColor(.accentColor)
                    .fontWeight(.bold)
                    .font(.system(size: 30))
                    .multilineTextAlignment(.center)
                    .padding(.top, 100)
                
                Text("Rate Your Route")
                    .foregroundColor(.accentColor)
                    .fontWeight(.regular)
                    .font(.system(size: 30))
                    .multilineTextAlignment(.center)
                    .padding(.top, 100)
                HStack {
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= rating ? "star.fill" : "star")
                            .foregroundColor(.accentColor)
                            .font(.system(size: 30))                            .onTapGesture {
                                rating = index // Update the selected rating
                            }
                            .padding(.horizontal, 4)
                    }
                }
                Spacer()

                NavigationLink(destination: HomeScreen()){
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
                            Text("Find Another Route")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                            }
                        }
                    }
                .padding(.bottom, 50)
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct CompletionScreen_Previews: PreviewProvider {
    static var previews: some View {
        CompletionScreen()
    }
}
