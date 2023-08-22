//
//  PastTripCard.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 21/08/23.
//

import SwiftUI

struct PastTripCard: View {
  
  // MARK: Properties
  var trip: TripPlans
  
  func getYear(_ dateNow: Date) -> String {
    let date = dateNow
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    return dateFormatter.string(from: date)
  }
  
  // MARK: View
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack {
        HStack(spacing: 4) {
          HStack(spacing: 4) {
            Image(systemName: "calendar")
            Text("\(trip.dateStart!...trip.dateEnd!), \(getYear(trip.dateEnd!))")
              .font(.footnote)
          }
          .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
          .background(Color(UIColor.pavel.darkGray))
          .cornerRadius(5)
          
          HStack(spacing: 4) {
            Image(systemName: "clock")
            Text("\(trip.duration) \(trip.duration > 1 ? "days" : "day")")
              .font(.footnote)
          }
          .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
          .background(Color(UIColor.pavel.darkGray))
          .cornerRadius(5)
        }
        .foregroundColor(Color(UIColor.pavel.white))
        Spacer()
        HStack(spacing: 4) {
          Text("Details")
            .font(.footnote)
          Image(systemName: "chevron.right")
            .font(.footnote)
        }
        .foregroundColor(Color.gray)
      }
      VStack(alignment: .leading, spacing: 5) {
        Text("\(trip.title!)")
          .font(.title3.bold())
        Divider()
          .padding(.vertical, 2)
        HStack {
          HStack {
            Text("\(trip.origin!)")
            Text("-")
            Text("\(trip.destination!)")
          }
          Spacer()
//          Text("\(trip.isAbroad!)")
        }
        .font(.footnote)
        .foregroundColor(Color.gray)
      }
      .foregroundColor(.black)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.all, 14)
    .background(.white)
    .cornerRadius(16)
  }
}

//struct PastTripCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PastTripCard()
//    }
//}
