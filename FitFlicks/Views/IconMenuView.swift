//
//  IconMenuView.swift
//  FitFlicks
//
//  Created by BeastMode on 8/6/25.
//


import SwiftUI

struct IconMenuView: View {
    
    var body: some View {
        HStack(spacing: 30) {
            
            IconButton(systemName: "play.fill", label: "Start") {
            }

            IconButton(systemName: "arrow.counterclockwise.circle.fill", label: "Reset") {
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

struct IconButton: View {
    let systemName: String
    let label: String
    let action: () -> Void

    var body: some View {
        VStack {
            Button(action: action) {
                Image(systemName: systemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(Color.blue.secondary.opacity(0.1))
                    .clipShape(Circle())
            }
            Text(label)
                .font(.caption)
                .foregroundColor(.primary)
        }
        }
    
    
}

#Preview{
    IconButton(systemName: "play.fill", label: "Start" ){
        
    }
}
