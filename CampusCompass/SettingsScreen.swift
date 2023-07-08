//
//  SettingsScreen.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/8/23.
//

import SwiftUI

struct SettingsScreen: View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        
        
        NavigationStack{
            VStack{
               Rectangle()
                    .frame(height:3)
                    .overlay(Color.black)
                    .shadow(color: Color.black, radius: 3, x:0, y: 4)
                    .position(x:0, y:3)
            }
        
            .navigationBarBackButtonHidden(true)
            .toolbar (content:{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Label("Back", systemImage: "arrowshape.backward")
                            .foregroundColor(.accentColor)
                            .padding(.leading, 10)
                            .bold()
                    })
                }
                ToolbarItem(placement: .principal){
                    Text("CampusCompass")
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                        .foregroundColor(Color.accentColor)
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: HomeScreen()){
                        Image(systemName:"house")
                            .foregroundColor(Color.accentColor)
                            .padding(.trailing, 10)
                            .bold()
                    }
                }
            })
        }
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}
