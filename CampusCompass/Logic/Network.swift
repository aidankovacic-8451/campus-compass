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
    @Published var schools: Array<School> = []
    
    @Published var loadError: LoadError? = nil
    
    // IP Address of services to connect to
    private let IP: String = "192.168.1.83"
    
    func fetchRoute(building: String, fromLocation: String, toLocation: String, accessibility: Bool) async {
        let jsonEncoder = JSONEncoder()
        guard let url = URL(string: "http://\(IP):3000/route/uc/\(building)")
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
                self.reportNoConnect()
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    self.loadError = nil
                    let substringRoute = String(decoding: data, as: UTF8.self)
                    let substringArray = substringRoute.split(whereSeparator: \.isNewline)
                    self.route = substringArray.map { (Substring) -> String in
                        String(Substring)
                    }
                }
                
            } else {
                self.reportError(errorCode: response.statusCode)
            }
        }.resume()
    }
    
    func fetchFeatures(building: String) async {
        guard let url = URL(string: "http://\(IP):8000/features/\(building)")
        else {
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error)
                self.reportNoConnect()
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    self.loadError = nil
                    do {
                        let decodedFeatures = try JSONDecoder().decode([FeatureMessage].self, from: data)
                        self.features = decodedFeatures.map {
                            $0.name
                        }
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
                
            } else {
                self.reportError(errorCode: response.statusCode)
            }
        }.resume()
    }
    
    func fetchBuildings(campus: String) async {
        guard let url = URL(string: "http://\(IP):8000/buildings/\(campus)")
        else {
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error)
                self.reportNoConnect()
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
                
            } else {
                self.reportError(errorCode: response.statusCode)
            }
        }.resume()
    }
    
    func fetchCampuses() async {
        guard let url = URL(string: "http://\(IP):8000/campus")
        else {
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error)
                self.reportNoConnect()
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    do {
                        let decodedFeatures = try JSONDecoder().decode([CampusMessage].self, from: data)
                        self.schools = decodedFeatures.map {
                            School(name: $0.name, internalName: $0.internal_name)
                        }
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
                
            } else {
                self.reportError(errorCode: response.statusCode)
            }
        }.resume()
    }
    
    func clearFeatureCache() {
        self.features = []
    }
    
    func clearBuildingCache() {
        self.buildings = []
    }
    
    // Error reporting functions
    private func reportNoConnect() {
        DispatchQueue.main.async {
            self.loadError = .unableToConnect
        }
    }
    
    private func reportError(errorCode: Int) {
        DispatchQueue.main.async {
            switch errorCode {
            case 500:
                self.loadError = .internalServerError
            case 404:
                self.loadError = .notFoundError
            default:
                self.loadError = .unknownError
            }
        }
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
    
    struct CampusMessage: Codable {
        let id: Int
        let name: String
        let internal_name: String
    }

}

enum LoadError {
    case internalServerError
    case unableToConnect
    case notFoundError
    case unknownError
    var description: String {
        switch self {
        case .internalServerError:
            return "Sorry, there was an error on our end 😨"
        case .unableToConnect:
            return "It appears you lack a connection or our servers are down.\n Please try again later."
        case .notFoundError:
            return "It appears that we can't find an entry in our server for your request.\n Please report this to the CampusCompass Team."
        case .unknownError:
            return "Unknown error. Please report to the CampusCompass Team."
        }
    }
}
