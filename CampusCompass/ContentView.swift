//
//  ContentView.swift
//  CampusCompass
//
//  Created by Aidan Kovacic on 6/26/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
           
        //This VStack aligns our homescreen UI including future functionality with buttons and logic
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
                
                //TODO: This button functionality needs to be built out
                
                Button{
                    print("this needs to go to the settings page")
                } label: {
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
                
            //TODO: This button functionality needs to be built out
            
            Button{
                print("This will take you to the search screen")
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.accentColor)
                        .frame(width:200, height: 150)
                    VStack{
                        Image(systemName: "magnifyingglass")
                            .resizable(resizingMode: .stretch)
                            .foregroundColor(Color.white)
                            .frame(width: 50.0, height: 50.0)
                        Text("Search for your school")
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                    }
                }
            }
            .padding(.top, 170.0)
            
            Spacer()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
