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
                    NavigationLink(destination: HomeScreen()){
                        Image(systemName:"house.fill")
                            .padding(.trailing, 20)
                            .bold()
                        }
                    }
                
                Divider()
                    .frame(height:3)
                    .overlay(Color.black)
                    .shadow(color: Color.black, radius: 3, x:0, y: 4)
               
                Spacer()
                
                VStack{
                    Text("Version:")
                        .font(.system(size:20))
                        .bold()
                    Text("Beta 1.0")
                        .padding(.bottom, 10)
                    Text("Release Date:")
                        .font(.system(size:20))
                        .bold()
                    Text("July 27, 2023")
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
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}




struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
            .environmentObject(Store())
    }
}
