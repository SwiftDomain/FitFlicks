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
    var themeColor: String = "000000"
    var count: Int = 0
    var badge: Badge = Badge.none
    
    init() {}
    
}

enum Badge: Codable{
    
    case none, iron, silver, gold, platinum, diamond, master, legend
    
    var descr: UIImage{
        
        switch self{
            
        case .iron:
            return UIImage(systemName: "chevron.up.2")!
            
        case .silver:
            return UIImage(systemName: "chevron.up.dotted.2")!
        case .gold:
            return UIImage(systemName: "text.line.magnify")!
            
        case .platinum:
            return UIImage(systemName: "chevron.compact.up.chevron.compact.right.chevron.compact.down.chevron.compact.left")!
            
        case .diamond:
            return UIImage(systemName: "chevron.up.chevron.right.chevron.down.chevron.left")!
            
        case .master:
            return UIImage(systemName: "tengesign.bank.building")!
            
        case .legend:
            return UIImage(systemName: "coat")!
            
        case .none:
            return UIImage(systemName: "progress.indicator")!
            
        }
    }
}



struct Flicks{
    
    var title: String
    var duration: String
    
    static func currentFlick() -> Flicks {
        let flicks = [
            Flicks(title: "45s Plank", duration: "00:45"),
            Flicks(title: "20 Jumping Jacks", duration: "~00:30"),
            Flicks(title: "1 Min Squat Hold", duration: "01:00"),
            Flicks(title: "15 Push-Ups", duration: "~00:45")
        ]
        return flicks.randomElement()!
    }
}

