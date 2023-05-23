//
//  Person.swift
//  who is it
//
//  Created by Jakub Górka on 22/05/2023.
//

import Foundation
import UIKit
import SwiftUI

class PersonModel: Codable, Identifiable, ObservableObject, Hashable {
    static func == (lhs: PersonModel, rhs: PersonModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    @Published var name: String
    @Published var imageData: Data
    var id: UUID
    var choosen: Bool = false
    var hidden: Bool = false
    
    init(name: String, imageData: Data, id: UUID) {
        self.name = name
        self.imageData = imageData
        self.id = id
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case imageData
        case id
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        imageData = try container.decode(Data.self, forKey: .imageData)
        id = try container.decode(UUID.self, forKey: .id)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(imageData, forKey: .imageData)
        try container.encode(id, forKey: .id)
    }
}



class PersonsStorageManager: ObservableObject {
    @Published var storedPersons: [PersonModel] = [] {
        didSet {
            // Whenever the storedPersons property changes, encode it and store the data in AppStorage
            if let encodedData = try? JSONEncoder().encode(storedPersons) {
                storedPersonsData = encodedData
            }
        }
    }

    @AppStorage("storedPersons") var storedPersonsData: Data?

    init() {
        if let storedData = storedPersonsData,
           let decodedData = try? JSONDecoder().decode([PersonModel].self, from: storedData) {
            storedPersons = decodedData
        }
        else{
            print("Error")
            if storedPersons.isEmpty{
                for i in 1...32{
                    self.addPerson(image: UIImage(systemName: "person.fill")!, name: "Postac \(i)")
                }
            }

        }
    }

    func addPerson(image: UIImage, name: String) {
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            var newPersons = storedPersons
            let newPerson = PersonModel(name: name, imageData: imageData, id: UUID())
            newPersons.append(newPerson)
            storedPersons = newPersons
        }
    }
    
    func updateAppStorage(){
        if let encodedData = try? JSONEncoder().encode(storedPersons) {
            storedPersonsData = encodedData
        }
    }
    
}


