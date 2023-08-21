//
//  CircleGroup.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 17/08/23.
//

import SwiftUI

struct CircleGroup: View {
  
  // MARK: Properties
  @State var shapeColor: Color
  @State var shapeOpacity: Double
  @State var isAnimating: Bool = false
  
  // MARK: View
  var body: some View {
    ZStack {
      Circle()
        .stroke(shapeColor.opacity(shapeOpacity), lineWidth: 40)
        .frame(width: 260, height: 260, alignment: .center)
      Circle()
        .stroke(shapeColor.opacity(shapeOpacity), lineWidth: 80)
        .frame(width: 260, height: 260, alignment: .center)
    }
    .blur(radius: isAnimating ? 0 : 10)
    .opacity(isAnimating ? 1 : 0)
    .scaleEffect(isAnimating ? 1 : 0.5)
    .onAppear {
      withAnimation(Animation.easeOut(duration: 1.5).repeatForever()) {
        isAnimating = true
      }
    }
  }
}

struct CircleGroup_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color(UIColor.pavel.navy)
        .ignoresSafeArea(.all, edges: .all)
      CircleGroup(shapeColor: .white, shapeOpacity: 0.2)
    }
  }
}

