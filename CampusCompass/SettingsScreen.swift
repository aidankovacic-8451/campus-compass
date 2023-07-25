//
//  SettingsScreen.swift
//  CampusCompass
//
//  Created by Nicholas Andrews on 7/8/23.
//
import MessageUI
import SwiftUI

struct SettingsScreen: View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var store: Store
    @State private var Feedback = ""
    
   var body: some View {
        
        NavigationStack{
            VStack{
                /*Rectangle()
                 .frame(height:3, alignment: .center)
                 .overlay(Color.black)
                 .shadow(color: Color.black, radius: 3, x:0, y: 4)*/
                
                
                Spacer()
                
                Text("Version:")
                    .font(.system(size:20))
                    .bold()
                Text("Beta 1.0")
                    .padding(.bottom, 10)
                Text("Release Date:")
                    .font(.system(size:20))
                    .bold()
                Text("July 21, 2023")
                    .padding(.bottom, 10)
                Text("Questions? Comments? Concerns?")
                    .font(.system(size:20))
                    .bold()
                    .padding(.top, 20)
                TextField("Type your feedback here", text: $Feedback)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .bottom, .trailing])
                Button(action: {
                    //sendEmail()
                }){
                    Text("Submit Feedback")
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
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
            .environmentObject(Store())
    }
}
