//
//  OnBoardingViewModel.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 18/08/23.
//

import Foundation

class OnBoardingViewModel: ObservableObject {
    var content = OnBoardingData.getOnBoarding()
}
