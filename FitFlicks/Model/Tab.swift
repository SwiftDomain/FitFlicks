import SwiftUI

enum TabViewEnum: Identifiable, CaseIterable, View, Hashable {
            
    case home, info, directions, faq
    
    var id: Self { self }
    
    var tabItem: TabItem {
       
        switch self {
            
            case .home:
                .init(name: "Welcome", systemImage: "house", color: .blue)
            case .info:
                    .init(name: "About Us", systemImage: "info", color: .green)
            case .directions:
                    .init(name: "Directions", systemImage: "map", color: .orange)
            case .faq:
                    .init(name: "FAQ", systemImage: "questionmark", color: .teal)
            
        }
    }
    
    var body: some View {
        
        switch self {
            case .home:
            FitFlicks(flick: Flick(), currentFlick: .PullUps)
            case .info:
            FitFlicks(flick: Flick(), currentFlick: .PullUps)
            case .directions:
            FitFlicks(flick: Flick(), currentFlick: .PullUps)
            case .faq:
            FitFlicks(flick: Flick(), currentFlick: .PullUps)
        }
        
    }
}

struct TabItem {
        
    let name: String
    let systemImage: String
    var color: Color
}


