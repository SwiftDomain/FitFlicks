//
//  FitFlicksApp.swift
//  FitFlicks
//
//  Created by BeastMode on 7/1/25.
//

import SwiftUI
import SwiftData

@main
struct FitFlicksApp: App {
    
    var modelContainer: ModelContainer
    
    init() {
        do {
            
            modelContainer = try ModelContainer(for: Flick.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

    }
    
    var body: some Scene {
        
        WindowGroup {
            Home()
        }
        .modelContainer(modelContainer)
    }
}

