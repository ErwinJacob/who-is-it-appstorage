//
//  ContentView.swift
//  who is it
//
//  Created by Jakub Górka on 22/05/2023.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @StateObject var personsStorageManager = PersonsStorageManager()
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass


    var body: some View {
        Group {
            if horizontalSizeClass == .compact && verticalSizeClass == .regular {
                // Landscape mode
                EditView(personsStorageManager: personsStorageManager)
            } else {
                // Portrait mode or other cases
                GameView(personsStorageManager: personsStorageManager)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
