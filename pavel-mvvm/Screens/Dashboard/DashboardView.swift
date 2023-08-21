//
//  DashboardView.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 18/08/23.
//

import SwiftUI
import CoreData

enum TabIdentifier {
  case upcoming
  case add
  case past
}

struct DashboardView: View {
  
  // MARK: Properties
  @Binding var path: [Screen]
  @State var selectedTab: TabIdentifier = .upcoming
  
  // MARK: PersistenceController
  let persistenceController = PersistenceController.shared
  
//  // MARK: CoreData
//  @Environment(\.managedObjectContext) private var viewContext
//  @FetchRequest(entity: TripPlans.entity(), sortDescriptors: [NSSortDescriptor(key: #keyPath(TripPlans.dateStart), ascending: true)])
//  private var tripPlans: FetchedResults<TripPlans>
  
  // MARK: View
  var body: some View {
    GeometryReader { geo in
      TabView(selection: $selectedTab) {
        UpcomingTripView()
          .tabItem {
            Label("Upcoming Trip", systemImage: "airplane.departure")
          }.tag(TabIdentifier.upcoming)
          .environment(\.managedObjectContext, persistenceController.container.viewContext)
        
        Button(action: {
        }) {}
          .tabItem {
            Label("Add Trip", systemImage: "plus.app")
          }.tag(TabIdentifier.add)
        
        PastTripView()
          .tabItem {
            Label("Past Trip", systemImage: "clock.arrow.circlepath")
          }.tag(TabIdentifier.past)
          .environment(\.managedObjectContext, persistenceController.container.viewContext)
      }
      .onChange(of: selectedTab) { newValue in
        switch newValue {
        case .upcoming:
          break
        case .add:
          path.append(Screen.CreateScreen)
          self.selectedTab = .upcoming
        case .past:
          break
        }
      }
    }
//    .navigationBarBackButtonHidden()
  }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
