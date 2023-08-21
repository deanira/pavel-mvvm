//
//  UpcomingTripView.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 18/08/23.
//

import SwiftUI
import CoreData

struct UpcomingTripView: View {
  
  // MARK: CoreData
  @Environment(\.managedObjectContext) private var viewContext
  @FetchRequest(entity: TripPlans.entity(), sortDescriptors: [NSSortDescriptor(key: #keyPath(TripPlans.dateStart), ascending: false)], predicate: NSPredicate(format: "(dateEnd >= %@) AND (dateStart <= %@)", NSDate(), NSDate())
  )
  private var ongoingTrip: FetchedResults<TripPlans>
  
  @FetchRequest(entity: TripPlans.entity(), sortDescriptors: [NSSortDescriptor(key: #keyPath(TripPlans.dateStart), ascending: false)], predicate: NSPredicate(format: "dateStart > %@", NSDate())
  )
  private var tripPlans: FetchedResults<TripPlans>
  
  // MARK: View
  var body: some View {
    VStack {
      VStack {
        VStack(alignment: .leading) {
          Image("pavel-stripe-light")
            .resizable()
            .scaledToFit()
            .frame(width: 80)
            .padding(.horizontal, 20)
          Image("clouds-fit")
            .resizable()
            .scaledToFit()
        }
        .background(
          Color(UIColor.pavel.red)
        )
        
        if !ongoingTrip.isEmpty {
          HStack {
            Text("On Going")
              .font(.system(size: 24))
              .fontWeight(.bold)
            Spacer()
          }
          .padding(.horizontal, 16)
          VStack {
            UpcomingTripCard(trip: ongoingTrip.first!)
          }
          .padding(.horizontal)
        }
        HStack {
          Text("Upcoming Trip")
            .font(.system(size: 24))
            .fontWeight(.bold)
          Spacer()
          Text("See All")
            .font(.callout)
            .foregroundColor(Color(UIColor.pavel.red))
        }
        .padding(.top)
        .padding(.horizontal)
        ScrollView {
          if tripPlans.isEmpty {
            Text("No data")
          } else {
            LazyVStack(spacing: 10) {
              ForEach(tripPlans) { trip in
                UpcomingTripCard(trip: trip)
              }
            }
            .padding(.horizontal)
          }
          
        }
      }
    }
    .background(Color(UIColor.pavel.background))
  }
}

struct UpcomingTripView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingTripView()
    }
}
