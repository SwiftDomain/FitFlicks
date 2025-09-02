import SwiftUI

enum TabViewEnum: Identifiable, CaseIterable, View, Hashable {
            
    case home, badges, info, directions, faq
    
    var id: Self { self }
    
    var tabItem: TabItem {
       
        switch self {
            
            case .home:
                .init(name: "Welcome", systemImage: "house", color: .blue)
            case .badges:
                    .init(name: "Badges", systemImage: "medal", color: .purple)
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
                FitFlicks()
            case .badges:
                BadgeView(badges: ["Star", "Silver", "Bronze"])
            case .info:
                FitFlicks()
            case .directions:
                FitFlicks()
            case .faq:
                FitFlicks()
        }
        
    }
}

struct TabItem {
        
    let name: String
    let systemImage: String
    var color: Color
}


