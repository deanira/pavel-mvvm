//
//  ActivityView.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 18/08/23.
//

import SwiftUI

struct ActivityView : View {
    @EnvironmentObject var trip: Trip
    @Binding var path: [Screen]
    @State var showAlert : Bool = false
    @StateObject private var viewModel = ActivityViewModel()
    
    var body: some View{
        ZStack{
            Color(UIColor.pavel.gray)
                .ignoresSafeArea()
            VStack(alignment: .leading,spacing: 5){
                Group{
                    Text("Select")
                    Text("Activities")
                }
                .bold()
                .font(.system(size: 40))
                Text("* YOU CAN SELECT MORE THAN ONE")
                Spacer()
                ScrollView{
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 170))], spacing: 15) {
                        ForEach(viewModel.activityList, id: \.self) { activity in
                            ActivityGrid(activity:activity)
                        }
                    }
                }
                Button{
                    if trip.TransportationList.isEmpty {
                        showAlert = true
                    } else {
                        viewModel.addTrip(trip: trip)
                        path.append(Screen.HomeScreen)
                    }
                    
                }label: {
                    Text("Generate Trip")
                }
                .foregroundColor(.white)
                .frame(maxWidth:.infinity,maxHeight: 50)
                .background(trip.TransportationList.isEmpty ? Color(UIColor.systemGray3):Color(UIColor.pavel.red))
                .cornerRadius(8)
                .alert(isPresented:$showAlert) {
                    Alert(title: Text("Incomplete Information"), message: Text("Please select one"), dismissButton: .default(Text("Got it!")))
                }
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
            .padding(.horizontal,16)
        }.onAppear(){
            if trip.ActivityListSuggestion.isEmpty{
                viewModel.activityList = Activity.content
            }else{
                
                for item in trip.ActivityListSuggestion{
                    let activity = Activity.content.first(where:{$0.title == item})
                    viewModel.activityList.append(activity!)
                }
            }
        }
        
    }
}

struct ActivityGrid : View{
    
    @EnvironmentObject var trip: Trip
    var activity:Activity
    
    var body: some View{
        Button {
            if trip.isActivityExist(activity: activity) {
                trip.removeActivity(activity:  activity)
            } else {
                trip.addNewActivity(activity: activity)
            }
        } label:{
            ZStack{
                
                Text(activity.image)
                    .grayscale(trip.isActivityExist(activity: activity) ?0:1)
                    .font(.system(size: 60, design: .rounded))
                    .frame(maxWidth:.infinity , maxHeight:.infinity ,alignment: .topLeading)
                    .padding(.horizontal,10)
                
                Image(systemName: trip.isActivityExist(activity: activity) ?"checkmark.square.fill":"square")
                    .grayscale(trip.isActivityExist(activity: activity) ?0:1)
                    .foregroundColor( trip.isActivityExist(activity: activity) ? .white:Color(UIColor.pavel.red))
                    .font(.system(size: 30, design: .rounded))
                    .frame(maxWidth:.infinity , maxHeight:.infinity ,alignment: .topTrailing)
                    .padding(.all,20)
                
                Text(activity.title)
                    .foregroundColor(trip.isActivityExist(activity: activity) ? .white : .black)
                    .font(.system(size: 24, design: .rounded))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth:.infinity , maxHeight:.infinity ,alignment: .bottomTrailing)
                    .padding(.all,20)
            }
            .frame(width: 170, height: 160, alignment: .topLeading)
            .background( trip.isActivityExist(activity: activity) ? Color(UIColor.pavel.red):.white)
            .cornerRadius(12)
        }
    }
}

//struct ActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityView()
//    }
//}
