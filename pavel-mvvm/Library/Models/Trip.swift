//
//  Trip.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 16/08/23.
//

import Foundation
import SwiftUI

//struct Trip: Identifiable, Hashable {
//  var id = UUID()
//  var title: String
//  var date: String
//  var duration: Int
//  var origin: String
//  var destination: String
//  var type: String
//}

class Trip: ObservableObject {
    // MARK: properties
    @Published var title: String = ""
    @Published var destination: String = ""
    @Published var dateStart: String = ""
    @Published var dateEnd: String = ""
    @Published var duration: Int = 0
    @Published var origin: String = ""
    @Published var isWinter: Bool = false
    @Published var isAbroad:Bool = false
    
    
    @Published var TransportationList: [Transportation] = []
    @Published var ActivityList: [Activity] = []
    @Published var ActivityListSuggestion: [String] = []
    
    func isTransportationExist(transportation: Transportation) -> Bool {
        if let _ = TransportationList.first(where: { $0.title == transportation.title }) {
            return true
        }
        return false
    }
    
    func addNewTransportation (transportation:Transportation){
        TransportationList.append(transportation)
    }
    
    func removeTransportation (transportation:Transportation){
        TransportationList.removeAll(where: { $0.title == transportation.title })
        
    }
    
    func isActivityExist(activity: Activity) -> Bool {
        if let _ = ActivityList.first(where: { $0.title == activity.title }) {
            return true
        }
        return false
    }
    
    func addNewActivity (activity:Activity){
        ActivityList.append(activity)
    }
    
    func removeActivity (activity:Activity){
        ActivityList.removeAll(where: { $0.title == activity.title })
    }
}
