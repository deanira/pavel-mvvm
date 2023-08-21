//
//  ListScreen.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 18/08/23.
//

import SwiftUI

struct ListScreen: View {
    @State private var favoriteColor = 0
    
    var body: some View {
        ZStack {
            Color(UIColor.pavel.gray)
                .ignoresSafeArea()
            
            VStack (alignment: .leading){
                VStack (alignment: .leading, spacing: 12) {
                    Text("Trip to Singapore")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    HStack (spacing: 24) {
                        Text("Tanggal")
                            .padding(4)
                            .foregroundColor(.white)
                            .background(Color(UIColor.pavel.red))
                        Text("4 days")
                            .padding(4)
                            .foregroundColor(.white)
                            .background(Color(UIColor.pavel.red))
                    }
                    Spacer()
                        .frame(height: 12)
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(20)
                
                Spacer()
                    .frame(height: 36)
                
                Picker("Menu?", selection: $favoriteColor) {
                    Text("Items").tag(0)
                    Text("Dcouments").tag(1)
                }.pickerStyle(.segmented)
                
                Spacer()
                    .frame(height: 48)
                
                Text("Item List")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("Here are the documents you need to bring for every activity you will do during this trip.")
                    .foregroundColor(.black)
                
                Spacer()
            }
        }
    }
}

struct ListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListScreen()
    }
}
