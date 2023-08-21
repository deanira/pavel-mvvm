//
//  Binding+Ext.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 16/08/23.
//

import Foundation
import SwiftUI

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}
