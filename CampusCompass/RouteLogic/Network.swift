//
//  Network.swift
//  CampusCompass
//
//  Created by Aidan Kovacic on 7/21/23.
//

import Foundation
import SwiftUI

class Network: ObservableObject {
    @Published var route: Array<String> = []
    @Published var features: Array<String> = []
    @Published var buildings: Array<Building> = []
    
    func fetchRoute(building: String, fromLocation: String, toLocation: String, accessibility: Bool) async {
        let jsonEncoder = JSONEncoder()
        guard let url = URL(string: "http://192.168.1.83:3000/route/uc/\(building)")
        else {
            return
        }
        let message = RouteMessage(fromLocation: fromLocation, toLocation: toLocation, accessibility: accessibility)
        guard let messageData = try? jsonEncoder.encode(message) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON

        request.httpBody = messageData
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    let substringRoute = String(decoding: data, as: UTF8.self)
                    let substringArray = substringRoute.split(whereSeparator: \.isNewline)
                    self.route = substringArray.map { (Substring) -> String in
                        String(Substring)
                    }
                }
                
            }
        }.resume()
    }
    
    func fetchFeatures(building: String) {
        guard let url = URL(string: "http://192.168.1.83:8000/features/\(building)")
        else {
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    do {
                        let decodedFeatures = try JSONDecoder().decode([FeatureMessage].self, from: data)
                        self.features = decodedFeatures.map {
                            $0.name
                        }
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
                
            }
        }.resume()
    }
    
    func fetchBuildings(campus: String) {
        guard let url = URL(string: "http://192.168.1.83:8000/buildings/\(campus)")
        else {
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    do {
                        let decodedFeatures = try JSONDecoder().decode([BuildingMessage].self, from: data)
                        self.buildings = decodedFeatures.map {
                            Building(name: $0.name, internalName: $0.internal_name)
                        }
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
                
            }
        }.resume()
    }

    struct RouteMessage: Codable {
        let fromLocation: String
        let toLocation: String
        let accessibility: Bool
    }
    
    struct FeatureMessage: Codable {
        let type: String
        let name: String
        let building_id: Int
        let id: Int
    }
    
    struct BuildingMessage: Codable {
        let id: Int
        let campus_id: Int
        let name: String
        let internal_name: String
    }

}
