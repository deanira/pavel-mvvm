//
//  HomeView.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 18/08/23.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: UserDefaults
    @AppStorage("onboarding") var isOnboardingViewActivate: Bool = true
    
    // MARK: PersistenceController
    let persistenceController = PersistenceController.shared
    
    // MARK: Properties
    @Binding var path: [Screen]
    @StateObject var trip  = Trip()
    
    // MARK: View
    var body: some View {
        print("Draw HomeScreen body")
        return NavigationStack(path: $path) {
            SplashScreen(path: $path)
                .environmentObject(trip)
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .OnBoardingScreen:
                        OnBoardingView(path: $path)
                    case .CreateScreen:
                        CreateView(path: $path)
                          .environmentObject(trip)
                          .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    case .TransportationScreen:
                        TransportationScreen(path: $path)
                            .environmentObject(trip)
                    case .ActivityScreen:
                        ActivityView(path: $path)
                            .environmentObject(trip)
                            .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    case .DashboardScreen:
                      DashboardView(path: $path)
                        .environmentObject(trip)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    case .ImagePreviewScreen(let image, let uiImage, let imageHasBeenChosen):
                        ImagePreviewView(path: $path, imageHasBeenChosen: imageHasBeenChosen, image: image, uiImage: uiImage)
                    default:
                        DocumentList( id: "D2566D93-ABBF-41C3-9C37-92AEB4A99761", path: $path)
                            .environmentObject(trip)
                            .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    }
                }
        }
        
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
