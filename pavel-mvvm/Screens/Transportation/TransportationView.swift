//
//  TransportationView.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 18/08/23.
//

import SwiftUI

struct TransportationView : View {
    
    @Binding var path: [Screen]
    @EnvironmentObject var trip: Trip
    @State var nextPage: Bool = false
    @State var showAlert : Bool = false
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View{
        ZStack{
            Color(UIColor.pavel.gray)
                .ignoresSafeArea()
            VStack(alignment: .leading,spacing: 5){
                Group{
                    Text("Select")
                    Text("Transportations")
                }
                .bold()
                .font(.system(size: 40))
                Text("* YOU CAN SELECT MORE THAN ONE")
                Spacer()
                ScrollView{
                    LazyVGrid(columns: adaptiveColumns, spacing: 15) {
                        ForEach(Transportation.content, id: \.self) { transportation in
                            TransportationGrid(transportation:transportation)
                        }
                    }
                }
                Button{
                    if trip.TransportationList.isEmpty {
                        showAlert = true
                    } else {
                        path.append(Screen.ActivityScreen)
                    }
                }label: {
                    Text("Next")
                }
                .foregroundColor(.white)
                .frame(maxWidth:.infinity,maxHeight: 50)
                .background(Color(UIColor.pavel.red))
                .cornerRadius(8)
                .alert(isPresented:$showAlert) {
                    Alert(title: Text("Incomplete Information"), message: Text("Please select one"), dismissButton: .default(Text("Got it!")))
                }
            }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
                .padding(.horizontal,16)
            
        }
    }
    
    struct TransportationGrid : View{
        @EnvironmentObject var trip: Trip
        var transportation: Transportation
        var body: some View{
            
            Button{
                if trip.isTransportationExist(transportation: transportation) {
                    trip.removeTransportation(transportation: transportation)
                } else {
                    trip.addNewTransportation(transportation: transportation)
                }
            }label:{
                ZStack{
                    
                    Text(transportation.image)
                        .grayscale(trip.isTransportationExist(transportation: transportation) ?0:1)
                        .font(.system(size: 60, design: .rounded))
                        .frame(maxWidth:.infinity , maxHeight:.infinity ,alignment: .topLeading)
                        .padding(.horizontal,10)
                    
                    Image(systemName: trip.isTransportationExist(transportation: transportation) ?"checkmark.square.fill":"square")
                        .grayscale(trip.isTransportationExist(transportation: transportation) ?0:1)
                        .foregroundColor( trip.isTransportationExist(transportation: transportation) ? .white:Color(UIColor.pavel.red))
                        .font(.system(size: 30, design: .rounded))
                        .frame(maxWidth:.infinity , maxHeight:.infinity ,alignment: .topTrailing)
                        .padding(.all,20)
                    
                    Text(transportation.title)
                        .foregroundColor(trip.isTransportationExist(transportation: transportation) ? .white : .black)
                        .font(.system(size: 24, design: .rounded))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth:.infinity , maxHeight:.infinity ,alignment: .bottomTrailing)
                        .padding(.all,20)
                }
                
                .frame(width: 170, height: 160, alignment: .topLeading)
                .background( trip.isTransportationExist(transportation: transportation) ? Color(UIColor.pavel.red):.white)
                .cornerRadius(12)
            }
        }
    }
}


//struct Transportation_Previews: PreviewProvider {
//    static var previews: some View {
//        TransportationScreen(path: .constant([Screen.TransportationScreen]))
//            .environmentObject(Trip())
//    }
//}

//struct TransportationView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransportationView()
//    }
//}
