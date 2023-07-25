//
//  RouteView.swift
//  CampusCompass
//
//  Created by Aidan Kovacic on 7/20/23.
//

import SwiftUI

struct RouteView: View {
    @EnvironmentObject var network: Network
    @EnvironmentObject var store: Store
    
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
                    }.padding(.top, 10)
                    
                }
                .padding(.horizontal)
                .padding(.top, 25)
                .frame(height: 400)
            }
            
            Button {
                Task {
                    await network.fetchRoute(building: store.selectedBuildingInternalName,
                                             fromLocation: store.selectedStartingLocationName,
                                             toLocation: store.selectedEndingLocationName,
                                             accessibility: store.enableAccessibilityMode)
                }
            } label: {
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 10)
                    .frame(width: 270, height: 100)
                    Text("Generate Route")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
            }
            .padding(.bottom, 40)

            Spacer()
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
    static var previews: some View {
        RouteView()
            .environmentObject(Network())
            .environmentObject(Store())
    }
}
