//
//  ImagePreviewViewModel.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 18/08/23.
//

import Foundation
import SwiftUI

class ImagePreviewViewModel: ObservableObject {
    @Binding var imageHasBeenChosen: Bool
    var fileManager = FileManager()
    
    var imageId = "image2"
    @Published var image: Image? = nil
    @Published var uiImage: UIImage? = nil
    
    func saveImage(with: String, image: UIImage) {
        fileManager.saveImage(with: with, image: image)
    }
    
    func retreiveImage(with: String) -> UIImage? {
        return fileManager.retrieveImage(with: with)
    }
}
