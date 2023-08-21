//
//  CreateView.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 18/08/23.
//

import SwiftUI
import CoreData

struct CreateView: View {
    @Binding var path: [Screen]
    
    // MARK: PersistenceController
    let persistenceController = PersistenceController.shared
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: Properties
    @EnvironmentObject var trip: Trip
    @State var sheetDestinationIsPresented = false
    @State var sheetOriginIsPresented = false
    @State var sheetDurationIsPresented = false
    @State var sheetDateIsPresented = false
    @State private var selectedIndexDuration = 0
    @StateObject var webService = CountriesService()
    @State var countryNames: [String] = []
    @State var selectedDate = Date()
    @State var showValidAlert = false
    @State var showInvalidDate = false
    @State var isValid = false
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMMM d, y"
        return df
    }()
    
    @State var generatedActivityList: [Activity] = []
    
    @StateObject private var viewModel = CreateViewModel()
    
    // MARK: View
    var body: some View {
        print("Draw CreateScreen body")
        print(trip)
        return VStack (alignment: .leading, spacing: 0) {
            Spacer()
                .frame(height: 20)
            Text("Create Trip")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
                .frame(height: 12)
            
            //MARK: Title
            Group {
                Group {
                    Text("Title")
                    Spacer()
                        .frame(height: 8)
                    Text("Name it something short and memorable")
                        .font(.system(size: 14))
                        .foregroundColor(Color.secondary)
                }
                Spacer()
                    .frame(height: 8)
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.white)
                    .frame(height: 40)
                    .overlay(
                        TextField(trip.title == "" ? "\"Bali Trip\", for example" : trip.title, text: $trip.title.max(30))
                            .padding(.horizontal, 14)
                    )
                Spacer()
                    .frame(height: 4)
                Text("\(30 - trip.title.count) characters left")
                    .font(.system(size: 12))
                    .fontWeight(.light)
                    .fontWeight(.light)
                    .foregroundColor(Color.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            //MARK: Destination
            Group {
                Spacer()
                    .frame(height: 16)
                Group {
                    Text("Destination")
                    Spacer()
                        .frame(height: 8)
                    Text("Where are you going?")
                        .font(.system(size: 14))
                        .foregroundColor(Color.secondary)
                    Spacer()
                        .frame(height: 8)
                    Button {
                        sheetDestinationIsPresented.toggle()
                    } label: {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.white)
                            .frame(height: 40)
                            .overlay(
                                HStack {
                                    Text(trip.destination == "" ? "Not yet selected" : trip.destination)
                                        .foregroundColor(trip.destination == "" ? .secondary : .black)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 14)
                            )
                    }
                }
            }
            .sheet(isPresented: $sheetDestinationIsPresented) {
                CountryStateSheet(webService: webService, result: $trip.destination, isPresented: $sheetDestinationIsPresented)
                    .presentationDetents([.fraction(0.95)])
            }
            
            //MARK: Origin
            Group {
                Spacer()
                    .frame(height: 16)
                Text("Origin")
                Spacer()
                    .frame(height: 8)
                Text("Where are you going to depart from?")
                    .font(.system(size: 14))
                    .foregroundColor(Color.secondary)
                Spacer()
                    .frame(height: 8)
                Button {
                    sheetOriginIsPresented.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.white)
                        .frame(height: 40)
                        .overlay(
                            HStack {
                                Text(trip.origin == "" ? "Not yet selected" : trip.origin)
                                    .foregroundColor(trip.origin == "" ? .secondary : .black)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 14)
                        )
                }
            }
            .sheet(isPresented: $sheetOriginIsPresented) {
                CountryStateSheet(webService: webService, result: $trip.origin, isPresented: $sheetOriginIsPresented)
                    .presentationDetents([.fraction(0.95)])
            }
            
            //MARK: Date
            Group {
                Spacer()
                    .frame(height: 16)
                Text("Date")
                Spacer()
                    .frame(height: 8)
                Text("When are you going?")
                    .font(.system(size: 14))
                    .foregroundColor(Color.secondary)
                Spacer()
                    .frame(height: 8)
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.white)
                    .frame(height: 56)
                    .overlay(
                        DatePicker(
                            selection: $selectedDate,
                            in: Date()...,
                            displayedComponents: .date
                        ) {
                            Text("Select a date")
                        }
                            .padding(.horizontal, 14)
                    )
                
            //MARK: Duration
            Group {
                Spacer()
                    .frame(height: 16)
                Text("Duration")
                Spacer()
                    .frame(height: 8)
                Text("The duration of your trip")
                    .font(.system(size: 14))
                    .foregroundColor(Color.secondary)
                Spacer()
                    .frame(height: 8)
                Button {
                    sheetDurationIsPresented.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.white)
                        .frame(height: 40)
                        .overlay(
                            HStack {
                                Text(trip.duration == 0 ? "Not yet selected" : trip.duration == 1 ? "\(trip.duration) day" : "\(trip.duration) days")
                                    .foregroundColor(trip.duration == 0 ? .secondary : .black)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 14)
                        )
                }
            }
            .sheet(isPresented: $sheetDurationIsPresented) {
                VStack(alignment: .trailing) {
                    Button {
                        trip.duration = selectedIndexDuration + 1
                        sheetDurationIsPresented.toggle()
                    } label: {
                        Text("Done")
                    }
                    
                    Picker("Duration", selection: $selectedIndexDuration) {
                        ForEach(1..<32) { i in
                            Text(i == 1 ? "\(i) day" : "\(i) days")
                        }
                    }
                    .pickerStyle(.wheel)
                    .presentationDetents([.fraction(0.3)])
                }
                .padding(.all, 16)
            }
            Spacer()
            
            Button {
                trip.dateStart = dateFormatter.string(from: selectedDate)
                var dateComponent = DateComponents()
                dateComponent.day = selectedIndexDuration
                let dateEnd = Calendar.current.date(byAdding: dateComponent, to: selectedDate)
                trip.dateEnd = dateFormatter.string(from:dateEnd!)
                if viewModel.checkTrip() {
                    switch trip.dateStart {
                    case let str where str.contains("December") && (trip.destination.contains("Tokyo")||trip.destination.contains("Kyōto Prefecture")):
                        trip.isWinter = true
                    default:
                        trip.isWinter = false
                    }
                    
                    let originCountry = trip.origin.split(separator: ",")[1].trimmingCharacters(in: .whitespacesAndNewlines)
                    if trip.destination.contains(originCountry) {trip.isAbroad = false}
                    else {trip.isAbroad = true}
                    
                    
                    switch trip.destination {
                    case let str where str.contains("Tokyo") :
                        trip.ActivityListSuggestion = ["Cycling", "Photography", "Running", "Party"]
                    case let str where str.contains("Kyōto Prefecture") :
                        trip.ActivityListSuggestion = ["Cycling", "Photography", "Running", "Party"]
                    case let str where str.contains("Bali") :
                        trip.ActivityListSuggestion = ["Kayaking", "Diving", "Surfing", "Camping", "Photography"]
                    default:
                        trip.ActivityListSuggestion = []
                    }
                    
                    print(trip.ActivityListSuggestion)
                    
                    if trip.title.isEmpty || trip.dateStart.isEmpty || trip.dateEnd.isEmpty  || trip.duration == 0 || trip.destination.isEmpty || trip.origin.isEmpty {
                        showValidAlert = true
                        isValid = false
                    } else {
                        showValidAlert = false
                        isValid = true
                        path.append(Screen.TransportationScreen)
                    }
                } else {
                    showInvalidDate = true
                }
            } label: {
                Text("Next")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth:.infinity, maxHeight: 48)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(Color(UIColor.pavel.red))
                    )
            }
            .alert(isPresented:$showValidAlert) {
                Alert(title: Text("Incomplete Information"), message: Text("Please fill in all required fields before proceeding."), dismissButton: .default(Text("Got it!")))
            }
            .alert(isPresented:$showInvalidDate) {
                Alert(title: Text("Invalid Date"), message: Text("You have another trip with same date"), dismissButton: .default(Text("Got it!")))
            }
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.path = [Screen.DashboardScreen]
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Back")
                    }
                }
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .environmentObject(trip)
        .task {
            do {
                try await webService.populateCountries()
            } catch {
                print("failed to fetch countries")
            }
        }
    }
}

struct CountryStateSheet: View {
    @State private var searchTextCountry = ""
    @State private var searchTextState = ""
    @State private var searchTextCity = ""
    @ObservedObject var webService: CountriesService
    @Binding var result: String
    @Binding var isPresented: Bool
    @State var countries: [Country] = []
    @State var states: [Province] = []
    @State var cities: [City] = []
    
    var searchResultsCountry: [Country] {
        if searchTextCountry.isEmpty {
            return countries
        } else {
            return countries.filter { $0.name.contains(searchTextCountry) }
        }
    }
    
    var searchResultsState: [Province] {
        if searchTextState.isEmpty {
            return states
        } else {
            return states.filter { $0.name.contains(searchTextState) }
        }
    }
    
    var searchResultsCity: [City] {
        if searchTextCity.isEmpty {
            return cities
        } else {
            return cities.filter { $0.name.contains(searchTextCity) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(searchResultsCountry, id: \.self.id) {itemCountry in
                        NavigationLink(value: itemCountry) {
                            Text(itemCountry.name)
                        }
                    }
                }
                .navigationDestination(for: Country.self) { country in
                    List {
                        ForEach(searchResultsState, id: \.self.id) {itemState in
                            Button {
                                result = "\(itemState.name), \(result)"
                                print(result)
                                isPresented.toggle()
                            } label: {
                                Text(itemState.name)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .navigationTitle("State")
                    //                    .navigationDestination(for: Province.self) { state in
                    //                        List {
                    //                            ForEach(searchResultsCity, id: \.self.id) {itemCity in
                    //                                Button {
                    //                                    result = "\(itemCity.name), \(result)"
                    //                                    print(result)
                    //                                    isPresented.toggle()
                    //                                } label: {
                    //                                    Text(itemCity.name)
                    //                                        .foregroundColor(.black)
                    //                                }
                    //                            }
                    //                        }
                    //                        .navigationTitle("City")
                    //                        .task {
                    //                            do {
                    //                                try await webService.populateCities(countryCode: country.iso2, provinceCode: state.iso2) { resultCities in
                    //                                    print("webservice cities: \(resultCities)")
                    //                                    cities = resultCities
                    //                                }
                    //                            } catch {
                    //                                print("failed to fetch countries")
                    //                            }
                    //                            cities = webService.cities
                    //                        }
                    //                        .searchable(text: $searchTextState)
                    //                    }
                    .searchable(text: $searchTextState)
                    .onAppear() {
                        result = country.name
                    }
                    .task {
                        print(country.iso2)
                        do {
                            try await webService.populateStates(countryCode: country.iso2) { resultStates in
                                print("webservice provinces: \(resultStates)")
                                states = resultStates
                            }
                        } catch {
                            print("failed to fetch countries")
                        }
                    }
                }
            }
            .navigationTitle("Country")
        }
        .onAppear() {
            countries = webService.countries
        }
        .searchable(text: $searchTextCountry)
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
