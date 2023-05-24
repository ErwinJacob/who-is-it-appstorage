//
//  ProfileEditorView.swift
//  who is it
//
//  Created by Jakub Górka on 22/05/2023.
//

import SwiftUI

struct ProfileEditorView: View {

    @State var person: PersonModel
    @State private var showSheet = false
    @ObservedObject var personsStorageManager: PersonsStorageManager
    @Environment(\.presentationMode) var presentationMode


    var body: some View {
        GeometryReader{ proxy in
            VStack(alignment: .center){
                
                Spacer()
                
                Button {
                    showSheet = true
                } label: {
                    Image(uiImage: UIImage(data: person.imageData)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                }
                    .frame(width: proxy.size.width*0.5, height: proxy.size.width*0.5)
//                    .padding(.top, proxy.size.height*0.1)

                Spacer()
                
                TextField("Imię", text: $person.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .bold()
                    .font(.title)
                    .frame(width: proxy.size.width*0.7)
                    .multilineTextAlignment(.center)
                

                Spacer()
                                
                Button {
                    personsStorageManager.updateAppStorage()
                    presentationMode.wrappedValue.dismiss()
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
            .sheet(isPresented: $showSheet) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $person.imageData)
            }
//            .navigationBarBackButtonHidden(true)
        }
    }
}

