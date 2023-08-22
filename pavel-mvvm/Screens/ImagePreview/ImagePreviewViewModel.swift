//
//  ImagePreviewViewModel.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 18/08/23.
//

import Foundation
import SwiftUI

class ImagePreviewViewModel: ObservableObject {
    private var fileManager = FileManager()
    
    func saveImage(with: String, image: UIImage) {
        fileManager.saveImage(with: with, image: image)
    }
    
    func retrieveImage(with: String) -> UIImage? {
        return fileManager.retrieveImage(with: with)
    }
}
