//
//  ActivityViewModel.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 18/08/23.
//

import Foundation
import CoreData

class ActivityViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.managedObjectContext
    @Published var activityList:[Activity] = []
    
    init() {}
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMMM d, y"
        return df
    }()
    
    func addTrip(trip: Trip){
        let newTrip = TripPlans(context: viewContext)
        newTrip.id = UUID()
        newTrip.title = trip.title
        newTrip.origin = trip.origin
        newTrip.destination = trip.destination
        newTrip.duration = Int32(trip.duration)
        newTrip.isAbroad = trip.isAbroad
        newTrip.dateStart = dateFormatter.date(from: trip.dateStart)
        newTrip.dateEnd = dateFormatter.date(from: trip.dateEnd)
        
        for category in trip.TransportationList {
            let newCategory = Categories(context:viewContext)
            newCategory.id = UUID()
            newCategory.name = category.title
            newCategory.icon = category.image
            newCategory.isWinter = false
            
            
            let arrFilter =  ItemPerCategory.content.filter { item in
                return item.category == category.title
            }
            
            for item in arrFilter {
                let newItem = Items(context:viewContext)
                newItem.id = UUID()
                newItem.name = item.itemName
                newItem.isCheck = false
                newItem.total = 1
                newCategory.addToItems(newItem)
                print(newItem)
            }
            
            newTrip.addToCategories(newCategory)
        }
        
        for category in trip.ActivityList {
            let newCategory = Categories(context:viewContext)
            newCategory.id = UUID()
            newCategory.name = category.title
            newCategory.icon = category.image
            newCategory.isWinter = false
            
            let arrFilter =  ItemPerCategory.content.filter { item in
                return item.category == category.title
            }
            
            for item in arrFilter {
                let newItem = Items(context:viewContext)
                newItem.id = UUID()
                newItem.name = item.itemName
                newItem.isCheck = false
                newItem.total = 1
                newItem.category = newCategory
                
                if item.isAbroad && trip.isAbroad{
                    newCategory.addToItems(newItem)
                }else if !item.isAbroad{
                    newCategory.addToItems(newItem)
                }
                
                
            }
            newTrip.addToCategories(newCategory)
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
}
