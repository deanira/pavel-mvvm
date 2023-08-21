//
//  TripScoreView.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 18/08/23.
//

import SwiftUI

struct TripScoreView: View {
    
    @State var progress = 0.0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Trip Score")
                .fontWeight(.bold)
                .font(.system(size: 36))
            
            Spacer()
                .frame(height: 12)
            
            Text("The results are in.")
                .fontWeight(.medium)
                .font(.system(size: 20))
            
            Spacer()
                .frame(height: 48)
            
            ZStack {
                
                Text("You forgot to check (or even bring)\n**6 out of 10 items**!")
                    .multilineTextAlignment(.center)
                    .padding(.top, 120)
                
                ZStack (alignment: .top) {
                    
                    HStack {
                        Spacer()
                        HalfCircleGaugeView(progress: $progress)
                        Spacer()
                    }
                    
                    VStack {
                        Text("40%")
                            .font(.system(size: 48))
                            .fontWeight(.bold)
                        Text("Dumbass")
                            .fontWeight(.semibold)
                    }
                    .padding(.top, 90)
                    
                }
            }
            
            Text("Seems quiet a bull-headed person you are, aren’t you? Good luck with your trip then!")
                .fontWeight(.medium)
                .font(.system(size: 20))
            
            Spacer()
        }
        .onAppear{
            withAnimation(Animation.easeInOut(duration: 2)){
                progress = 0.2
            }
        }
        .padding(.horizontal, 24)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.pavel.redPinkishTransparent), Color(UIColor.pavel.redPinkish)]), startPoint: .top, endPoint: .bottom))
        
    }
}

struct HalfCircleGaugeView: View {
    @Binding var progress : Double
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.5)
                .stroke(
                    Color.white,
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(180))
                .frame(width: UIScreen.main.bounds.width / 1.4, height: UIScreen.main.bounds.height / 2.5)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.yellow,
                    style: StrokeStyle(
                        lineWidth: 24,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(180))
                .frame(width: UIScreen.main.bounds.width / 1.4, height: UIScreen.main.bounds.height / 2.5)
                
        }
    }
}

struct TripScoreView_Previews: PreviewProvider {
    static var previews: some View {
        TripScoreView()
    }
}
