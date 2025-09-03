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
    @State private var themeColor = Color.blue
     
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 0) {
                
                /* Top Section */
                    VStack(alignment: .center){
                        
                        Text("FitFlicks")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(themeColor)
                        
                        Text("🔥Streak: \(flickCount) days")
                            .font(.subheadline)
                    }
                .padding(.vertical, 32)
                
               /* Mid Section */
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(themeColor.secondary.opacity(0.2))
                        .frame(maxHeight: .infinity)
            
                    HStack{
                        VStack {
                            Text(currentFlick.title)
                                .font(.title2)
                                .bold()
                            
                            Text(currentFlick.duration.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 16)
                        
                        Spacer()
                        
                        VStack{
                            Image("Jump")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
                    }
                    
                }
                .frame(height: 100)
                
                /* Mid Section */
                ZStack(alignment: .top) {
                     
                     RoundedRectangle(cornerRadius: 20)
                         .fill(themeColor.secondary.opacity(0.2))
                         .frame(maxHeight: .infinity)
                
                    VStack{
                        
                        StopwatchView()
                        
                        Spacer()
                        
                        /* Quick Fit Button */
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
                                .background(themeColor).opacity(1)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.vertical, 32)
                        
                    }
                 }
                .padding(.vertical, 16)


                
                
                if showReward {
                    Text("🎉 Bonus Unlocked! 🎉")
                        .font(.headline)
                        .foregroundColor(.orange)
                }

                Spacer()
            }
            .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .phone ? 20 : 40)
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
