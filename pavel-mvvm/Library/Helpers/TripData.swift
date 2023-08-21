//
//  TripData.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 16/08/23.
//

import SwiftUI

class TripData {
  static func getUpcomingTrips() -> [Trip] {
    return [Trip(title: "Trip To Denpasar, Bali", date: "22 - 25 Jun 2023", duration: 4, origin: "Jakarta", destination: "Bali", type: "International"),
            Trip(title: "Vacation To Tokyo", date: "12 - 16 Jul 2023", duration: 5, origin: "Jakarta", destination: "Tokyo", type: "Domestic"),
            Trip(title: "Singapore Trip 4D3N", date: "2 - 4 Sep 2023", duration: 3, origin: "Jakarta", destination: "Sarawak", type: "International"),
    ]
  }
  
  static func getPastTrips() -> [Trip] {
    return [Trip(title: "Trip To Denpasar, Bali", date: "22 - 25 Jun 2023", duration: 4, origin: "Jakarta", destination: "Bali", type: "International"),
            Trip(title: "Vacation To Tokyo", date: "12 - 16 Jul 2023", duration: 5, origin: "Jakarta", destination: "Tokyo", type: "Domestic"),
    ]
  }
}
