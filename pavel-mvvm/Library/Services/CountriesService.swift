//
//  CountriesService.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 21/08/23.
//

import Foundation

class CountriesService: ObservableObject {
    @Published var countries : [Country] = []
    @Published var provinces : [Province] = []
    @Published var cities : [City] = []
    
    func populateCountries() async throws {
        var request = URLRequest(url: URL(string: "\(AppConfig.API_LINK)countries")!)
        request.httpMethod = "GET"
        request.addValue(AppConfig.API_KEY, forHTTPHeaderField: "X-CSCAPI-KEY")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            
            DispatchQueue.main.async {
                do {
                    self.countries = try JSONDecoder().decode([Country].self, from: data)
                } catch {
                    print("Unable to Decode Response \(error)")
                }
                
            }
        }.resume()
    }
    
    func populateStates(countryCode: String, onComplete: @escaping ([Province]) -> Void) async throws {
        var request = URLRequest(url: URL(string: "\(AppConfig.API_LINK)countries/\(countryCode)/states")!)
        request.httpMethod = "GET"
        request.addValue(AppConfig.API_KEY, forHTTPHeaderField: "X-CSCAPI-KEY")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            
            DispatchQueue.main.async {
                do {
                    self.provinces = try JSONDecoder().decode([Province].self, from: data)
                    onComplete(self.provinces)
                } catch {
                    print("Unable to Decode Response \(error)")
                }
            }
        }.resume()
    }
    
    func populateCities(countryCode: String, provinceCode: String, onComplete: @escaping ([City]) -> Void) async throws {
        var request = URLRequest(url: URL(string: "\(AppConfig.API_LINK)countries/\(countryCode)/states/\(provinceCode)/cities")!)
        request.httpMethod = "GET"
        request.addValue(AppConfig.API_KEY, forHTTPHeaderField: "X-CSCAPI-KEY")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            
            DispatchQueue.main.async {
                do {
                    self.cities = try JSONDecoder().decode([City].self, from: data)
                    onComplete(self.cities)
                } catch {
                    print("Unable to Decode Response \(error)")
                }
            }
        }.resume()
    }
    
    func checkCitiesIsExisted(countryCode: String, provinceCode: String) -> Bool {
        if cities.count < 1 {return false}
        else {return true}
    }
}
