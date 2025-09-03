//
//  ContentView.swift
//  FitFlicks
//
//  Created by BeastMode on 7/1/25.
//

import SwiftUI

struct FitFlicks: View {
    
    @State var flick: Flick = Flick()
    @State private var currentFlick: FullBody
    @State private var flickCount = 0
    @State private var showReward = false
    @State private var showBadgeAlert = false
    @State private var themeColor = Color.blue
    
    init(flick: Flick, currentFlick: FullBody, flickCount: Int = 0, showReward: Bool = false, showBadgeAlert: Bool = false, themeColor: SwiftUICore.Color = Color.blue) {
        self.flick = flick
        self.currentFlick = currentFlick
        self.flickCount = flickCount
        self.showReward = showReward
        self.showBadgeAlert = showBadgeAlert
        self.themeColor = themeColor
    }
     
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
                            Text(flick.fullBody.title)
                                .font(.title2)
                                .bold()
                            
                            Text("\(flick.fullBody.duration)")
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
                            currentFlick = flick.fullBody                      
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
    FitFlicks(flick: Flick(), currentFlick: .PullUps)
}
