//
//  ImagePreviewView.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 18/08/23.
//

import SwiftUI

struct ImagePreviewView: View {
    @Binding var path: [Screen]
    @StateObject private var viewModel = ImagePreviewViewModel()
    
    
    
    var body: some View {
        VStack {
            if viewModel.imageHasBeenChosen {
                Image(uiImage: viewModel.retrieveImage(with: imageId)!)
                    .resizable()
                    .scaledToFit()
            } else {
                image
                    .resizable()
                    .scaledToFit()
            }
        }.toolbar {
            Button("Save") {
                viewModel.saveImage(with: imageId, image: uiImage)
//                fileManager.saveImage(with: imageId, image: uiImage)
                viewModel.imageHasBeenChosen = true
                _ = path.popLast()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

//struct ImagePreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImagePreviewView()
//    }
//}
