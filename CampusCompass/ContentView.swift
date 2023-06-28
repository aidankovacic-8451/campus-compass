//
//  ContentView.swift
//  CampusCompass
//
//  Created by Aidan Kovacic on 6/26/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        //This ZStack allows the background color to stay behind the other elements of the welcome screen
        ZStack{
            
            //This sets the welcome screen background color
            Color("AccentColor")
                .ignoresSafeArea()
            
            //This VStack aligns all visible elements of welcome screen
            VStack{
                Spacer()
                
                //This imports the png file of the logo and aligns it
                Image("ccoutline")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.leading, 100.0)
                    
                //This displays the welcome message to users
                Text("Welcome to CampusCompass")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Spacer()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
