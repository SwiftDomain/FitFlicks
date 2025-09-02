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
            
            VStack(spacing: 20) {
                
                /* Top Section */
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
                            .font(.subheadline)
                    }
                }
                
                /* Mid Section */
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(themeColor.opacity(0.1))
                        .frame(maxHeight: .infinity)
                    
                    VStack {
                        
                        VStack {
                            Text(currentFlick.title)
                                .font(.title2)
                                .bold()
                            
                            Text(currentFlick.duration.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        StopwatchView()

                    }
                }

                /* Quick Fit Button */
                Button(action: {
                    flickCount += 1
                    showReward = flickCount % 5 == 0
                    currentFlick = Flicks.currentFlick()
                    checkBadges()
                    print(checkOSVersion())
                }) {
                    Text("Quick Fit")
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(themeColor).opacity(1)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.bottom, 25)
                
                if showReward {
                    Text("🎉 Bonus Unlocked! 🎉")
                        .font(.headline)
                        .foregroundColor(.orange)
                }

                //Spacer()
            }
            .padding(.horizontal, 40)
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
    
    func checkOSVersion() {
        
        let processInfo = ProcessInfo.processInfo
        let osVersion = processInfo.operatingSystemVersion

        print("Operating System Version: \(processInfo.description) \(osVersion.majorVersion).\(osVersion.minorVersion).\(osVersion.patchVersion)")

        if processInfo.isOperatingSystemAtLeast(OperatingSystemVersion(majorVersion: 15, minorVersion: 0, patchVersion: 0)) {
            print("OS is at least iOS/macOS 15.0")
        }
    }

    // Call the function in your SwiftUI view or elsewhere
    // checkOSVersion()
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
