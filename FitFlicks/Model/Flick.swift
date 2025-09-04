//
//  Flicks.swift
//  FitFlicks
//
//  Created by BeastMode on 7/1/25.
//

import SwiftUI
import SwiftData

@Model
class Flick: ObservableObject, Identifiable{
    
    private(set) var id = UUID()
    
    var straightDay: Int = 0
    var count: Int = 0
    var mode: Mode = Mode.beginner
    
    init() {}
    
    var fullBody: FullBody{
        return FullBody.allCases.randomElement()!
    }
    
    var core: Core{
        return Core.allCases.randomElement()!
    }
    
    var cardio: Cardio{
        return Cardio.allCases.randomElement()!
    }
    
}

enum FullBody: CaseIterable{
    
    case pushUps
    case pullUps
    case airSquats
    case jumpSquats
    case pistolSquats
    case bulgarianSplitSquats
    case lunges
    case walkingLunges
    case wallSits
    case cossackSquats
    case goodMornings
    case calfRaises
    case singleLegCalfRaises
    
    var title: String{
        
        switch self {
        case .pushUps:
            return "Push-Ups"
        case .pullUps:
            return "Pull-Ups"
        case .airSquats:
            return "Air Squats"
        case .jumpSquats:
            return "Jump Squats"
        case .pistolSquats:
            return "Pistol Squats"
        case .bulgarianSplitSquats:
            return "Bulgarian Split Squats"
        case .lunges:
            return "Lunges"
        case .walkingLunges:
            return "Walking Lunges"
        case .wallSits:
            return "Wall Sits"
        case .cossackSquats:
            return "Cossack Squats"
        case .goodMornings:
            return "Good Mornings"
        case .calfRaises:
            return "Calf Raises"
        case .singleLegCalfRaises:
            return "Single Leg Calf Raises"
        }
    }
    
    var icon: Image{
        
        switch self {
            case .pushUps:
            return Image("Push-Ups")
        case .pullUps:
            return Image("Pull-Ups")
        case .airSquats:
            return Image("Squats")
        case .jumpSquats:
            return Image("Squats")
        case .pistolSquats:
            return Image("Squats")
        case .bulgarianSplitSquats:
            return Image("Squats")
        case .lunges:
            return Image("lunges")
        case .walkingLunges:
            return Image("walkinglunges")
        case .wallSits:
            return Image("wallsit")
        case .cossackSquats:
            return Image("Squats") 
        case .goodMornings:
            return Image("goodmorning")
        case .calfRaises:
            return Image("calfraise")
        case .singleLegCalfRaises:
            return Image("singlelegcalfraise")
            
        }
        
    }
    
}


enum Core: CaseIterable{
    
    case Crunches
    case SitUps
    case mountainClimbers
    case russianTwists
    case standardPlank
    case sidePlanks
    case plankJacks
    case birdDog
    case bearCrawl
    
}

enum Cardio: CaseIterable{
    
    case Burpees
    case starJumps
    case highKnees
    case buttKicks
    case jumpingJacks
    case lateralBounds
    case skaterHops
    case tuckJumps
    case sprintInPlace
    case wallSit
    case hollowBodyHold
    case supermanHold
    case bridgeHold
    case squatHold
    case lungeHold
    case LSit
}

enum Mode: Codable{
    
    case beginner
    case intermediate
    case advanced
    
    var timeInterval: TimeInterval{
        
        switch self{
            
        case .beginner:
            return 30
        case .intermediate:
            return 60
        case .advanced:
            return 120
            
        }
    }
    
    var descr: String{
        
        switch self{
        case .beginner:
            return "Beginner"
        case .intermediate:
            return "Intermediate"
        case .advanced:
            return "Advanced"
        }
    }
}

class ThemeColor {
    
    private var COLOR_KEY = "COLOR_KEY"
    private let userDefaults = UserDefaults.standard
    
    func saveColor(color: Color) {
        // Convert the color into RGB
        let color = UIColor(color).cgColor
        
        // Save the RGB into an array
        if let components = color.components {
            userDefaults.set(components, forKey: COLOR_KEY)
            
        }
    }
    
    func loadColor() -> Color{
        // Get the RGB array
        guard let array = userDefaults.object(forKey: COLOR_KEY) as? [CGFloat] else { return Color.blue }
        
        // Create a color from the RGB array
        let color = Color(.sRGB,
                          red: array[0],
                          green: array[1],
                          blue: array[2],
                          opacity: array[3])
        
        return color
    }
}
