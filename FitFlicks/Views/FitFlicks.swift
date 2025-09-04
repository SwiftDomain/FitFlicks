//
//  ContentView.swift
//  FitFlicks
//
//  Created by BeastMode on 7/1/25.
//

import SwiftUI
import SwiftData

struct FitFlicks: View {
    
    @Environment(\.modelContext) var context
    @Query private var flick: [Flick]
    
    @State private var currentFlick: FullBody = Flick().fullBody
    @State var themeColor = ThemeColor().loadColor()
    @State var stopWatch: StopwatchView = StopwatchView()
    
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 0) {
                
                /* Top Section */
                VStack(alignment: .center){
                    
                    Text("FitFlicks")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(themeColor)
                    
                    Text("🔥Streak: \(flick.first?.count ?? 0) days")
                        .font(.subheadline)
                }
                .padding(.vertical, 32)
                
                /* Exercise Section */
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.clear)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .shadow(radius: 4)
                
                    HStack{
                        VStack {
                            Text(currentFlick.title)
                                .font(.title2)
                                .bold()
                            
                            Text("\(flick.first?.mode.descr ?? "No Mode")")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 16)
                        
                        Spacer()
                        
                        VStack{
                            currentFlick.icon
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
                    }
                    
                }
                .frame(height: 100)
                
                
                /* Mid Section */
                ZStack(alignment: .top) {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.clear)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .shadow(radius: 4)
                    
                    VStack{
                        
                        // StopwatchView()
                        stopWatch
                            .padding(.horizontal, 16)
                        
                        Spacer()
                        
                        /* Quick Fit Button */
                        Button(action: {
                          stopWatch.reset()
                            currentFlick = flick.first?.fullBody ?? .pushUps
                        }) {
                            HStack {
                                
                                Image(systemName: "flame.fill")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                Text("Flick it")
                                    .font(.title2)
                                    .bold()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(themeColor).opacity(1)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                            .padding(.vertical, 32)
                        }
                    }
                }
                .padding(.vertical, 16)
                
                Spacer()
            }
            .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .phone ? 16 : 64)
            .onAppear() {
                themeColor = ThemeColor().loadColor()
                
                if flick.isEmpty {
                    let flickData = Flick()
                    context.insert(flickData)
                }
            }
        }
    }
    
}


struct SettingsView: View {
    
    @State private var color: Color = Color.black
    var themeColor = ThemeColor()
    
    var body: some View {
        
        ZStack{
            
            Rectangle()
                .foregroundColor(color)
                .ignoresSafeArea()
            
            VStack() {
                
                Spacer()
                
                ColorPicker("Pick a color:", selection: $color)
                    .padding(.horizontal, 64)
                    .font(.title)
                
                Spacer()
                
                Button(action: {
                    themeColor.saveColor(color: color)
                    print("Color Loaded: \(color.description)")
                    
                }) {
                    Text("Save Color")
                        .font(.title3)
                        .padding()
                        .cornerRadius(20)
                }
                Spacer()
            }
        }
        .onAppear {
            color = themeColor.loadColor()
            print("Color Loaded: \(color.description)")
        }
        
    }
}

struct FitFlicksView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        FitFlicks()
            .modelContainer(for: Flick.self, inMemory: true)
        
    }
}

