//
//  OnBoarding.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 16/08/23.
//

import Foundation
import SwiftUI

struct OnBoarding: Identifiable, Hashable {
  var id = UUID()
  var title: String
  var image: String = ""
  var desc: String
  var background: UIColor
}
