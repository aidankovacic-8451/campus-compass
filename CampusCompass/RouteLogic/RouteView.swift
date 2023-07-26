//
//  RouteView.swift
//  CampusCompass
//
//  Created by Aidan Kovacic on 7/20/23.
//

import SwiftUI

struct RouteView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var network: Network
    @EnvironmentObject var store: Store
    @Binding var fromLocation: String
    @Binding var toLocation: String
    
    @State var errorState: Bool = false
    
    var body: some View {
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
        
        VStack(spacing: 0) {
            GeometryReader { mainView in
                ScrollView {
                    VStack (spacing: 15) {
                        ForEach(network.route, id: \.self) { dir in
                            GeometryReader { item in
                                DirectionView(direction: dir)
                                    .scaleEffect(scaleValue(mainFrame: mainView.frame(in: .global).minY, minY: item.frame(in: .global).minY), anchor: .bottom)
                                    .opacity(Double(scaleValue(mainFrame: mainView.frame(in: .global).minY, minY: item.frame(in: .global).minY)))
                            }
                            .frame(height: 80)
                            
                        }
                    }.padding(.top, 10)
                    
                }
                .padding(.horizontal)
                .padding(.top, 25)
                .frame(height: 400)
            }
            
            .navigationBarBackButtonHidden(true)
            Spacer()
            
            NavigationLink(destination: CompletionScreen()){
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 170, height: 70)
                        .foregroundColor(Color.accentColor)
                    Text("Complete Route")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
            }
            .padding(.bottom, 20)
        }
        .task {
            await network.fetchRoute(building: store.selectedBuildingInternalName,
                                     fromLocation: self.fromLocation,
                                     toLocation: self.toLocation,
                                     accessibility: store.enableAccessibilityMode)
        }
        .onChange(of: network.loadError) { newValue in
            self.errorState = newValue != nil
        }
        // Error handling
        .alert("Error", isPresented: $errorState, presenting: network.loadError) { error in
            Button {
                Task {
                    await network.fetchRoute(building: store.selectedBuildingInternalName,
                                             fromLocation: self.fromLocation,
                                             toLocation: self.toLocation,
                                             accessibility: store.enableAccessibilityMode)
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
    
    // Credits to https://www.youtube.com/watch?v=EBbhIbI2Hg8 for this animation solution
    func scaleValue(mainFrame: CGFloat, minY: CGFloat) -> CGFloat {
        let scale = (minY - 25) / mainFrame
        
        if scale > 1 {
            return 1
        } else {
            return scale
        }
    }
}

struct DirectionView : View {
    
    @State private var isTapped = false
    
    var direction: String
    
    var body: some View {
        GeometryReader { item in
            ZStack {
                RoundedRectangle(cornerRadius: 17)
                    .fill(!isTapped ? .white : .gray)
                    .opacity(!isTapped ? 1 : 0.2)
                    .frame(height: 80)
                    .padding(.horizontal)
                    .shadow(radius: 5)
                Text(direction)
                    .foregroundColor(.black)
                    .opacity(!isTapped ? 1 : 0.4)
                    .padding(.horizontal, 22)
            }
            .onTapGesture {
                isTapped = isTapped ? false : true
            }
        }
        Spacer(minLength: 50)
    }
}


struct RouteView_Previews: PreviewProvider {
    @State static var fromLocation: String = "101"
    @State static var toLocation: String = "303"
    static var previews: some View {
        RouteView(fromLocation: $fromLocation, toLocation: $toLocation)
            .environmentObject(Network())
            .environmentObject(Store())
    }
}
