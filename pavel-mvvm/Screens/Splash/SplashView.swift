//
//  SplashView.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 18/08/23.
//

import SwiftUI
import SceneKit

struct SplashScreen: View {
  
  // MARK: Properties
  @Binding var path: [Screen]
  @State private var firstBubbleAnimated: Bool = true
  @State private var secondBubbleAnimated: Bool = false
  
  // MARK: View
  var body: some View {
    print("Draw SplashScreen body")
    return GeometryReader { geo in
      VStack {
        Spacer()
          .frame(height: 24)
        VStack {
          RotatingLogo()
            .scaledToFit()
            .scaleEffect(0.6)
        }
        
      }
      .frame(width: geo.size.width, height: geo.size.height)
      .edgesIgnoringSafeArea(.all)
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
          path.append(Screen.HomeScreen)
        }
      }
    }
  }
}

struct RotatingLogo: UIViewRepresentable {
  
  let sceneView = SCNView()
  
  func makeUIView(context: Context) -> SCNView {
    
    sceneView.scene = SCNScene(named: "PAVEL2.usdz")
    sceneView.autoenablesDefaultLighting = true
    sceneView.allowsCameraControl = true
    
    let rotation = SCNAction.rotateBy(x: 0, y: CGFloat.pi * 2, z: 0, duration: 1.2)
    rotation.timingMode = .easeInEaseOut
    
    let repeatRotation = SCNAction.repeat(rotation, count: 1)
    sceneView.scene?.rootNode.runAction(repeatRotation)
    
    return sceneView
  }
  
  func updateUIView(_ uiView: SCNView, context: Context) {
      
  }
  
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashView()
//    }
//}
