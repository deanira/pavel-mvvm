//
//  CreateViewModel.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 18/08/23.
//

import Foundation

class CreateViewModel: ObservableObject {
    
    func checkTrip() -> Bool {
        var data:[TripPlans]
        let fetchRequest =  NSFetchRequest<TripPlans>(entityName: "TripPlans")
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
}
