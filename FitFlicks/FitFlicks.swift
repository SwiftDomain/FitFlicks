//
//  ContentView.swift
//  FitFlicks
//
//  Created by BeastMode on 7/1/25.
//

import SwiftUI

struct FitFlicks: View {
    
    @State private var flickCount = 0
    @State private var currentFlick: Flicks = Flicks.currentFlick()
    @State private var showReward = false
    @State private var badges: [String] = []
    @State private var showBadgeAlert = false
    @State private var themeColor = Color.green
     
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 20) {
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(themeColor.opacity(0.1))
                        .frame(height:100)
                    VStack{
                        Text("FitFlicks")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(themeColor)
                        
                        
                        Text("Streak: \(flickCount) days")
                            .font(.headline)
                    }
                }
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(themeColor.opacity(0.2))
                        .frame(maxHeight: .infinity)
                    
                    VStack {
                        Text(currentFlick.title)
                            .font(.title2)
                            .bold()
                        Text(currentFlick.duration)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        StopwatchView()
                    }
                    
                }

                Button(action: {
                    flickCount += 1
                    showReward = flickCount % 5 == 0
                    currentFlick = Flicks.currentFlick()
                    checkBadges()
                }) {
                    Text("Quick Fit")
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(themeColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                if showReward {
                    Text("🎉 Bonus Unlocked! 🎉")
                        .font(.headline)
                        .foregroundColor(.orange)
                }

                NavigationLink(destination: BadgeView(badges: badges)) {
                    Text("🏅 View Badges")
                        .font(.subheadline)
                }

                NavigationLink(destination: ThemeSettingsView(themeColor: $themeColor)) {
                    Text("🎨 Customize Theme")
                        .font(.subheadline)
                }

                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .alert("🏅 New Badge Earned!", isPresented: $showBadgeAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }

    private func checkBadges() {
        if flickCount == 1 && !badges.contains("Iron Starter") {
            badges.append("Iron Starter")
            showBadgeAlert = true
        } else if flickCount == 5 && !badges.contains("Flick Five") {
            badges.append("Flick Five")
            showBadgeAlert = true
        } else if flickCount == 10 && !badges.contains("Double Digit Dynamo") {
            badges.append("Double Digit Dynamo")
            showBadgeAlert = true
        }
    }
}

struct BadgeView: View {
    let badges: [String]

    var body: some View {
        List {
            ForEach(badges, id: \ .self) { badge in
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(badge)
                }
            }
        }
        .navigationTitle("Your Badges")
    }
}

struct ThemeSettingsView: View {
    @Binding var themeColor: Color

    var body: some View {
        Form {
            Section(header: Text("Select Theme Color")) {
                ColorPicker("Pick a Color", selection: $themeColor)
            }
        }
        .navigationTitle("Theme Settings")
    }
}

#Preview {
    FitFlicks()
}
