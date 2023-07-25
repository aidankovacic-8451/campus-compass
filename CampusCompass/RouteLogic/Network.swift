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
    
    func fetchRoute(building: String, fromLocation: String, toLocation: String, accessibility: Bool) async {
        let jsonEncoder = JSONEncoder()
        guard let url = URL(string: "http://192.168.182.128:3000/route/uc/\(building)")
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
                print(String(decoding: data, as: UTF8.self))
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

    struct RouteMessage: Codable {
        let fromLocation: String
        let toLocation: String
        let accessibility: Bool
    }

}
