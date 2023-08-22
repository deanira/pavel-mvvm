//
//  CreateViewModel.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 18/08/23.
//

import Foundation
import CoreData

class CreateViewModel: ObservableObject {
    @Published var webService = CountriesService()
    @Published var countryNames: [String] = []
    
    @Published var countries: [Country] = []
    @Published var states: [Province] = []
    @Published var cities: [City] = []
    
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMMM d, y"
        return df
    }()
    
    let viewContext = PersistenceController.shared.managedObjectContext
    
    func checkTrip(trip: Trip) -> Bool {
        var data:[TripPlans]
        let fetchRequest = NSFetchRequest<TripPlans>(entityName: "TripPlans")
        fetchRequest.sortDescriptors = []
        fetchRequest.predicate = NSPredicate(format: "(dateStart <= %@) && (dateEnd >= %@)", dateFormatter.date(from: trip.dateEnd)! as CVarArg , dateFormatter.date(from: trip.dateStart)!  as  CVarArg)
        
        fetchRequest.fetchLimit = 1
        do {
            data = try viewContext.fetch(fetchRequest)
            
            if(data.isEmpty){
                return true
            }else{
                print(data.first!)
            }
        } catch {
            print("Cannot fetch Expenses")
        }
        return false
    }
    
    func populateCountries() async {
        do {
            try await webService.populateCountries()
            self.countries = webService.countries
        } catch {
            print("failed to fetch countries")
        }
    }
    
    func populateStates(country: Country) async {
        do {
            try await webService.populateStates(countryCode: country.iso2) { resultStates in
                self.states = resultStates
            }
        } catch {
            print("failed to fetch countries")
        }
    }
}
