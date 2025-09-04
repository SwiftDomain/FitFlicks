import SwiftUI

enum TabViewEnum: Identifiable, CaseIterable, View, Hashable {
    
    case home, settings, directions, faq
    
    var id: Self { self }
    
    var tabItem: TabItem {
        
        switch self {
            
        case .home:
                .init(name: "Welcome", systemImage: "house", color: .blue)
        case .settings:
                .init(name: "Settings", systemImage: "gear", color: .green)
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
            
        case .settings:
            SettingsView()
            
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


