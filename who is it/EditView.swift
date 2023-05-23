//
//  EditView.swift
//  who is it
//
//  Created by Jakub Górka on 22/05/2023.
//

import SwiftUI

struct EditView: View {
        
    @ObservedObject var personsStorageManager: PersonsStorageManager

    var body: some View {
        NavigationView{
            GeometryReader{ proxy in

                ScrollView{
                    ForEach(personsStorageManager.storedPersons){ person in
                        NavigationLink(destination: ProfileEditorView(person: person, personsStorageManager: personsStorageManager)) {
                            HStack{
                                Image(uiImage: UIImage(data: person.imageData)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .frame(width: proxy.size.width*0.35, height: proxy.size.width*0.35)
                                Spacer()
                                Text(person.name)
                                Spacer()
                            }
                            .padding(.horizontal, proxy.size.width*0.05)
                        }
                        .frame(width: proxy.size.width, height: proxy.size.width*0.4)
                        

                    }
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
}

