//
//  DocumentListView.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 18/08/23.
//

import SwiftUI
import CoreData

struct DocumentList: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var path: [Screen]
    @State var newDocumentTitle = ""
    @State private var showActionSheet = false
    @State private var showImagePicker = false
    @State private var image: Image?
    @State private var uiImage: UIImage?
    @State private var imageHasBeenChosen = false
    @State private var isResult = false
    @FetchRequest private var tripPlans: FetchedResults<TripPlans>
    
    init (id: String = "", path: Binding<[Screen]>) {
        let request: NSFetchRequest<TripPlans> = TripPlans.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@ ",UUID(uuidString: id)! as CVarArg)
        request.sortDescriptors = []
        _tripPlans = FetchRequest(fetchRequest: request, animation: .default)
        
        _path = path
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.pavel.gray)
            VStack(alignment: .leading) {
                Text("Document List")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.pavel.darkGray))
                Text("Here are the documents you need to bring for every activity you will do during this trip.")
                    .foregroundColor(.gray)
                Spacer()
                    .frame(height: 24)
                VStack (alignment: .leading) {
                    DisclosureGroup {
                        VStack {
                            if isResult {
                                ScrollView(.horizontal) {
                                    HStack {
                                        ForEach(1..<4) { item in
                                            ItemDocumentResult()
                                                .padding(4)
                                                .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 1)
                                        }
                                    }
                                }
                            } else {
                                ForEach(1..<4) { item in
                                    ItemDocument(item: item)
                                        .padding(.bottom, item != 4 ? 16 : 0)
                                }
                                
                                HStack {
                                    Image(systemName: "plus")
                                        .foregroundColor(Color(UIColor.pavel.red))
                                    TextField("Add document title", text: $newDocumentTitle)
                                    Spacer()
                                    
                                    Button {
                                        if imageHasBeenChosen {
                                            path.append(Screen.ImagePreviewScreen(image!, uiImage!, $imageHasBeenChosen))
                                        } else {
                                            self.showImagePicker = true
                                        }
                                    } label: {
                                        HStack(spacing: 4) {
                                            if !imageHasBeenChosen {
                                                Image(systemName: "square.and.arrow.up")
                                            }
                                            Text(imageHasBeenChosen ? "See File" : "Upload File")
                                            if imageHasBeenChosen {
                                                Image(systemName: "chevron.right")
                                            }
                                        }
                                        .padding(.vertical, 4)
                                        .padding(.horizontal, 8)
                                        .background(
                                            RoundedRectangle(cornerRadius: 4)
                                                .foregroundColor(Color(UIColor.systemGray6))
                                        )
                                        .font(.caption)
                                        .foregroundColor(Color(UIColor.pavel.red))
                                    }
                                }
                                
                            }
                        }
                        .padding(.vertical, 16)
                        .padding(.horizontal, 4)
                    } label: {
                        Text("🚗  Transportation")
                            .foregroundColor(Color(UIColor.pavel.darkGray))
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical, 8).padding(.horizontal)
                    .background(Color.white).cornerRadius(8)
                }
            }
            .padding(.all, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$image, uiImage: self.$uiImage, showImagePicker: self.$showImagePicker)
            }.onAppear(){
                print("soini cuk")
                addItemsPicture(category: "Transportation")
                print("categories array", self.tripPlans)
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = image else { return }
        guard let inputUIImage = uiImage else { return }
        
        path.append(Screen.ImagePreviewScreen(image!, uiImage!, $imageHasBeenChosen))
    }
    
    func addItemsPicture(category:String) {
        withAnimation{
            viewContext.perform {
                do {
                    if let parentObject = tripPlans.first{
                        print("sini wak dososososo")
                        let newDocument = Documents(context: viewContext)
                        newDocument.id = UUID()
                        newDocument.title = "title1"
                        newDocument.file = "title"
                        parentObject.addToDocuments(newDocument)
                    }
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
            
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: Image?
    @Binding var uiImage: UIImage?
    @Binding var showImagePicker: Bool
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        // No update needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = Image(uiImage: uiImage)
                parent.uiImage = uiImage
            }
            
            parent.showImagePicker = false
        }
    }
}

struct ItemDocument: View {
    var item: Int
    var body: some View {
        HStack {
            Checkbox()
            Spacer()
            Text("Flight Ticket JKT - SIN")
            Spacer()
            Spacer()
            Button {
                
            } label: {
                HStack {
                    Text("See file")
                    Image(systemName: "chevron.forward")
                }
                .foregroundColor(Color(UIColor.pavel.red))
                .font(.caption)
            }
        }
    }
}

struct ItemDocumentResult: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.clear.overlay(
                Image("ticket")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            HStack {
                Text("Flight Ticket JKT - SIN")
                Spacer()
                Image(systemName: "chevron.right")
            }
            .font(.system(size: 14))
            .foregroundColor(Color(UIColor.pavel.red))
            .padding(.all, 12)
            .background(.white)
        }
        .frame(width: 200, height: 150)
        .fixedSize()
        .cornerRadius(8)
    }
}

struct Checkbox: View {
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 2)
                .stroke(
                    Color(UIColor.pavel.red),
                    lineWidth: 2
                )
                .frame(maxWidth: 20, maxHeight: 20)
            Image(systemName: "checkmark")
                .foregroundColor(Color(UIColor.pavel.red))
        }
    }
}

//struct DocumentListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DocumentListView()
//    }
//}
