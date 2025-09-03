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
    
    case PushUps
    case PullUps
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
        case .PushUps:
            return "Push-Ups"
        case .PullUps:
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
    
    var duration: TimeInterval{
        
        switch self {
        case .PushUps:
            return 5000
        case .PullUps:
            return 5000
        case .airSquats:
            return 5000
        case .jumpSquats:
            return 5000
        case .pistolSquats:
            return 5000
        case .bulgarianSplitSquats:
            return 5000
        case .lunges:
            return 5000
        case .walkingLunges:
            return 5000
        case .wallSits:
            return 5000
        case .cossackSquats:
            return 5000
        case .goodMornings:
            return 5000
        case .calfRaises:
            return 5000
        case .singleLegCalfRaises:
            return 5000
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


