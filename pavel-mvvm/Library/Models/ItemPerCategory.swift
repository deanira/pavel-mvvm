//
//  ItemPerCategory.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 21/08/23.
//

import Foundation
import SwiftUI

struct ItemPerCategory: Identifiable, Hashable {
    var id = UUID()
    var category: String
    var itemName: String
    var isAbroad: Bool = false
    var image: String = ""
}

extension ItemPerCategory {
  static var content: [ItemPerCategory] {
    [
        ItemPerCategory(category: "Essential", itemName: "Item List"),
        ItemPerCategory(category: "Essential", itemName: "Cell Phone Charger"),
        ItemPerCategory(category: "Essential", itemName: "Umbrella"),
        ItemPerCategory(category: "Essential", itemName: "Medication"),
        ItemPerCategory(category: "Essential", itemName: "Wallet"),
        ItemPerCategory(category: "Essential", itemName: "Smartphone"),
        ItemPerCategory(category: "Essential", itemName: "Passport", isAbroad: true),
        ItemPerCategory(category: "Essential", itemName: "Bottle"),
        ItemPerCategory(category: "Essential", itemName: "International Adapter", isAbroad: true),
        ItemPerCategory(category: "Camping", itemName: "Tent"),
        ItemPerCategory(category: "Camping", itemName: "Flashlight"),
        ItemPerCategory(category: "Camping", itemName: "Sleeping Bag"),
        ItemPerCategory(category: "Camping", itemName: "Cooking tools"),
        ItemPerCategory(category: "Camping", itemName: "First Aid Kit"),
        ItemPerCategory(category: "Personal Care", itemName: "Shampoo"),
        ItemPerCategory(category: "Personal Care", itemName: "Soap"),
        ItemPerCategory(category: "Personal Care", itemName: "Deodorant"),
        ItemPerCategory(category: "Personal Care", itemName: "Toothbrush"),
        ItemPerCategory(category: "Personal Care", itemName: "Toothpaste"),
        ItemPerCategory(category: "Personal Care", itemName: "Sunscreen"),
        ItemPerCategory(category: "Personal Care", itemName: "Face wash"),
        ItemPerCategory(category: "Beach", itemName: "Beach Swimsuit"),
        ItemPerCategory(category: "Beach", itemName: "Sunglasess"),
        ItemPerCategory(category: "Beach", itemName: "Hat"),
        ItemPerCategory(category: "Beach", itemName: "Sandals"),
        ItemPerCategory(category: "Beach", itemName: "Beach Towels"),
        ItemPerCategory(category: "Surfing", itemName: "Surfboard"),
        ItemPerCategory(category: "Surfing", itemName: "Leash"),
        ItemPerCategory(category: "Surfing", itemName: "Surf wax"),
        ItemPerCategory(category: "Surfing", itemName: "Wetsuit"),
        ItemPerCategory(category: "Photography", itemName: "Batteries"),
        ItemPerCategory(category: "Photography", itemName: "Battery Charger"),
        ItemPerCategory(category: "Photography", itemName: "Camera bag"),
        ItemPerCategory(category: "Photography", itemName: "Camera Charger"),
        ItemPerCategory(category: "Photography", itemName: "Lenses"),
        ItemPerCategory(category: "Photography", itemName: "Camera"),
        ItemPerCategory(category: "Photography", itemName: "Tripod"),
        ItemPerCategory(category: "Cruising", itemName: "Swimsuit"),
        ItemPerCategory(category: "Cruising", itemName: "Formal Clothes"),
        ItemPerCategory(category: "Cruising", itemName: "Sunglasess"),
        ItemPerCategory(category: "Cruising", itemName: "Camera"),
        ItemPerCategory(category: "Cruising", itemName: "Chalk bag and climbing chalk"),
        ItemPerCategory(category: "Climbing", itemName: "Helmet"),
        ItemPerCategory(category: "Climbing", itemName: "Locking Carabiner"),
        ItemPerCategory(category: "Climbing", itemName: "Climbing Harness"),
        ItemPerCategory(category: "Climbing", itemName: "Belay Device"),
        ItemPerCategory(category: "Climbing", itemName: "Climbing Shoes"),
        ItemPerCategory(category: "Climbing", itemName: "Climbing ropes"),
        ItemPerCategory(category: "Climbing", itemName: "Slings"),
        ItemPerCategory(category: "Climbing", itemName: "Quickdraws"),
        ItemPerCategory(category: "Skiing", itemName: "Ski/Snowboard"),
        ItemPerCategory(category: "Skiing", itemName: "Ski/Snowboard boots"),
        ItemPerCategory(category: "Skiing", itemName: "Poles"),
        ItemPerCategory(category: "Skiing", itemName: "Helmet"),
        ItemPerCategory(category: "Skiing", itemName: "Gloves"),
        ItemPerCategory(category: "Skiing", itemName: "Goggles"),
        ItemPerCategory(category: "Skiing", itemName: "Warm hat/beanie"),
        ItemPerCategory(category: "Skiing", itemName: "Ski socks"),
        ItemPerCategory(category: "Skiing", itemName: "Lip Balm"),
        ItemPerCategory(category: "Kayaking", itemName: "WetSuit/DrySuit"),
        ItemPerCategory(category: "Kayaking", itemName: "Kayak"),
        ItemPerCategory(category: "Kayaking", itemName: "Kayaking Shoes"),
        ItemPerCategory(category: "Kayaking", itemName: "Helmet"),
        ItemPerCategory(category: "Kayaking", itemName: "Helmet"),
        ItemPerCategory(category: "Party", itemName: "Party Outfit"),
        ItemPerCategory(category: "Diving", itemName: "Wetsuit"),
        ItemPerCategory(category: "Diving", itemName: "Snorkel"),
        ItemPerCategory(category: "Diving", itemName: "Mask"),
        ItemPerCategory(category: "Diving", itemName: "Buoyancy Control Device(BCD)"),
        ItemPerCategory(category: "Airplane", itemName: "Boarding pass"),
        ItemPerCategory(category: "Airplane", itemName: "Book"),
        ItemPerCategory(category: "Airplane", itemName: "Eye mask"),
        ItemPerCategory(category: "Airplane", itemName: "Travel pillow"),
        ItemPerCategory(category: "Train", itemName: "Ticket"),
        ItemPerCategory(category: "Train", itemName: "Book"),
        ItemPerCategory(category: "Train", itemName: "Travel pillow"),
        ItemPerCategory(category: "Train", itemName: "Eye mask"),
        ItemPerCategory(category: "Car", itemName: "Drivel license"),
        ItemPerCategory(category: "Car", itemName: "Sunglasses"),
        ItemPerCategory(category: "Ship", itemName: "Motion sickness pill"),
        ItemPerCategory(category: "Ship", itemName: "Ticket"),
        ItemPerCategory(category: "Motorcycle", itemName: "Helmet"),
        ItemPerCategory(category: "Motorcycle", itemName: "Jacket"),
        ItemPerCategory(category: "Motorcycle", itemName: "Sunglasses"),
        ItemPerCategory(category: "Motorcycle", itemName: "Mask"),
        ItemPerCategory(category: "Motorcycle", itemName: "Gloves"),
        ItemPerCategory(category: "Clothes", itemName: "Shirts"),
        ItemPerCategory(category: "Clothes", itemName: "Pants"),
        ItemPerCategory(category: "Clothes", itemName: "Undies"),
        ItemPerCategory(category: "Clothes", itemName: "Socks"),
        ItemPerCategory(category: "Running", itemName: "Running shoes"),
        ItemPerCategory(category: "Running", itemName: "Bottle"),
        ItemPerCategory(category: "Sailing", itemName: "Travel bag"),
        ItemPerCategory(category: "Sailing", itemName: "Sunscreen"),
        ItemPerCategory(category: "Cycling", itemName: "Bottle"),
        ItemPerCategory(category: "Cycling", itemName: "Bike"),
        ItemPerCategory(category: "Cycling", itemName: "Helmet"),
    ]
  }
}
