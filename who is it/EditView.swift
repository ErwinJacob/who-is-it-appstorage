//
//  EditView.swift
//  who is it
//
//  Created by Jakub Górka on 22/05/2023.
//

import SwiftUI

struct EditView: View {
        
    @ObservedObject var personsStorageManager: PersonsStorageManager
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView{
            GeometryReader{ proxy in
                
                ScrollView{
                    ForEach(personsStorageManager.storedPersons){ person in
                        NavigationLink(destination: ProfileEditorView(person: person, personsStorageManager: personsStorageManager)) {
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                    .opacity(0.05)

                                HStack{
                                    Image(uiImage: UIImage(data: person.imageData)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                        .frame(width: proxy.size.width*0.35, height: proxy.size.width*0.35)
                                    Spacer()
                                    Text(person.name)
                                        .bold()
                                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                    Spacer()
                                }
                                .padding(.horizontal, proxy.size.width*0.05)

                            }
                            .padding(.horizontal, proxy.size.width*0.05)
                        }
                        .frame(width: proxy.size.width, height: proxy.size.width*0.4)
                        

                    }
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
                
            }
        }
    }
    
}

