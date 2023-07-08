//
//  SchoolSearchScreen.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/8/23.
//

import SwiftUI

struct SchoolSearchScreen: View {
    var body: some View {
        
        VStack{
            
            HStack{
                NavigationLink(destination: HomeScreen()){
                    Image(systemName:"house")
                        .padding(.leading, 20)
                        .foregroundColor(Color.accentColor)
                }
                
                Spacer()
                
                Text("CampusCompass")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .foregroundColor(Color.accentColor)
                Spacer()
                
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
        }
    }
}
        


struct SchoolSearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SchoolSearchScreen()
    }
}
