//
//  Activity.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 21/08/23.
//

import Foundation

struct Activity: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var isWinter: Bool
    var image: String = ""
}

extension Activity {
  static var content: [Activity] {
    [
        Activity(title: "Cycling",isWinter:false, image: "🚴‍♀️"),
        Activity(title: "Kayaking",isWinter:false, image: "🚣"),
        Activity(title: "Sailing",isWinter:false, image: "⛵️"),
        Activity(title: "Surfing",isWinter:false, image: "🏄"),
        Activity(title: "Diving",isWinter:false, image: "🤿"),
        Activity(title: "Climbing",isWinter:false, image: "🧗‍♀️"),
        Activity(title: "Running",isWinter:false, image: "🏃‍♂️"),
        Activity(title: "Party",isWinter:false, image: "🎉"),
        Activity(title: "Winter Sports",isWinter:true, image: "⛷️"),
        Activity(title: "Photography",isWinter:false, image: "📷"),
        Activity(title: "Cruising",isWinter:false, image: "🚢"),
        Activity(title: "Camping",isWinter:false, image: "⛺️"),
    ]
  }
}
