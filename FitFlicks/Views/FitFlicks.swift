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
    
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 0) {
                
                /* Top Section */
                VStack(alignment: .center){
                    
                    Text("FitFlicks")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(themeColor)
                    
                    Text("🔥Streak: \(flick.first!.count) days")
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
                            
                            Text("\(flick.first!.mode.descr)")
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
                        .fill(ThemeColor().loadColor().secondary.opacity(0.2))
                        .frame(maxHeight: .infinity)
                    
                    VStack{
                        
                        StopwatchView()
                        
                        Spacer()
                        
                        /* Quick Fit Button */
                        Button(action: {
                            currentFlick = flick.first!.fullBody
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

//struct FitFlicksView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        
//        FitFlicks()
//            .modelContainer(for: Flick.self, inMemory: true)
//        
//    }
//}

