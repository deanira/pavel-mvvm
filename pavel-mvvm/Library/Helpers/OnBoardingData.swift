//
//  OnBoardingData.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 16/08/23.
//

import SwiftUI

class OnBoardingData {
  static func getOnBoarding() -> [OnBoarding] {
    return [OnBoarding(title: "Create Your Packing List", image: "char-1", desc: "Start by creating a custom packing list for your trip.", background: UIColor.pavel.navy),
            OnBoarding(title: "Get Recommended Packing Lists", image: "char-2", desc: "We provide curated packing lists based on your destination. Choose from a list of essentials!", background: UIColor.pavel.blue),
            OnBoarding(title: "Stay Organized and Never Forget", image: "char-3", desc: "Stay organized and never forget anything with our app. You'll be fully prepared for your trip!", background: UIColor.pavel.red),
    ]
  }
}
