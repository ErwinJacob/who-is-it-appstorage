//
//  ProfileEditorView.swift
//  who is it
//
//  Created by Jakub Górka on 22/05/2023.
//

import SwiftUI
import PhotosUI

struct ProfileEditorView: View {

    @State var person: PersonModel
    @ObservedObject var personsStorageManager: PersonsStorageManager
    @Environment(\.presentationMode) var presentationMode
    @State private var pickerImageData: PhotosPickerItem?
    @State var pickerImage: Image?


    var body: some View {
        GeometryReader{ proxy in
            VStack(alignment: .center){
                
                Spacer()
                
                PhotosPicker(selection: $pickerImageData) {
                    if let pickerImage{
                        pickerImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                    }
                    else{
                        Image(uiImage: UIImage(data: person.imageData)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                    }
                }
                .frame(width: proxy.size.width*0.5, height: proxy.size.width*0.5)
                .onChange(of: pickerImageData) { _ in
                            Task {
                                if let data = try? await pickerImageData?.loadTransferable(type: Data.self) {
                                    if let uiImage = UIImage(data: data) {
                                        pickerImage = Image(uiImage: uiImage)
                                        return
                                    }
                                    
                                }

                                print("Failed")
                            }
                        }
                
                Spacer()
                
                TextField("Imię", text: $person.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .bold()
                    .font(.title)
                    .frame(width: proxy.size.width*0.7)
                    .multilineTextAlignment(.center)
                

                Spacer()
                                
                Button {

                    Task{
                        if let data = try? await pickerImageData?.loadTransferable(type: Data.self) {
                            person.imageData = data
                            personsStorageManager.updateAppStorage()
                            presentationMode.wrappedValue.dismiss()

                        }
                    }
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: proxy.size.width*0.65, height: proxy.size.height*0.05)
                            .foregroundColor(.green)
                        Text("Save :)")
                            .foregroundColor(.white)
                            .bold()

                    }
                        .padding(.bottom, proxy.size.height*0.05)

                }


                Spacer()
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
//            .navigationBarBackButtonHidden(true)
        }
    }
}

