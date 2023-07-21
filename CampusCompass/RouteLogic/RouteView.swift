//
//  RouteView.swift
//  CampusCompass
//
//  Created by Aidan Kovacic on 7/20/23.
//

import SwiftUI

struct RouteView: View {
    @EnvironmentObject var network: Network
    @EnvironmentObject var accessibiltySetting: AccessibilitySetting
    @EnvironmentObject var schoolSelection: SchoolSelection
    @EnvironmentObject var buildingSelection: BuildingSelection
    @EnvironmentObject var startingLocationSelection: StartingLocationSelection
    @EnvironmentObject var endingLocationSelection: EndingLocationSelection
    
    var body: some View {
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
                    }.padding(.leading, 10)
                    
                }
                .padding(.horizontal)
                .padding(.top, 25)
                .frame(height: 500)
            }
            
            
            
            Button {
                Task {
                    await network.fetchRoute(fromLocation: "111", toLocation: "312", accessibility: true)
                }
            } label: {
                Text("Fetch Route")
            }
        }
        
    }
    
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
                RoundedRectangle(cornerRadius: 25)
                    .fill(!isTapped ? .red : .gray)
                    .opacity(!isTapped ? 1 : 0.2)
                    .frame(height: 80)
                    .padding(.horizontal)
                    .shadow(radius: 5)
                Text(direction)
                    .foregroundColor(.white)
                    .opacity(!isTapped ? 1 : 0.4)
            }
            .onTapGesture {
                isTapped = isTapped ? false : true
            }
        }
        
        Spacer(minLength: 50)

    }
}


struct RouteView_Previews: PreviewProvider {
    static var previews: some View {
        RouteView()
            .environmentObject(Network())
            .environmentObject(SchoolSelection())
            .environmentObject(BuildingSelection())
            .environmentObject(StartingLocationSelection())
            .environmentObject(EndingLocationSelection())
            .environmentObject(AccessibilitySetting())
    }
}
