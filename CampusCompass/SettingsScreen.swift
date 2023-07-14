//
//  SettingsScreen.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/8/23.
//

import SwiftUI

struct SettingsScreen: View {
    
    @State private var enableAccessibilityRouting = true
    @State private var accessibilityMode: Bool = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var schoolSelection: SchoolSelection

    var body: some View {
        
        
        
        NavigationStack{
            VStack{
                    /*Rectangle()
                        .frame(height:3, alignment: .center)
                        .overlay(Color.black)
                        .shadow(color: Color.black, radius: 3, x:0, y: 4)*/
                        
                        
                    Spacer()
                
                    Text("Display settings info here")
                
                    Spacer()
                
                
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
            .ignoresSafeArea()
        }
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
            .environmentObject(SchoolSelection())
    }
}
