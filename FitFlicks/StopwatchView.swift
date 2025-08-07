//
//  StopwatchView.swift
//  FitFlicks
//
//  Created by BeastMode on 8/6/25.
//


import SwiftUI
import AVFoundation
import UIKit

struct StopwatchView: View {
    @State private var timeElapsed: TimeInterval = 0
    @State private var timerRunning = false
    @State private var timer: Timer?
    @State private var laps: [TimeInterval] = UserDefaults.standard.array(forKey: "laps") as? [TimeInterval] ?? []
    @State private var countdownMode = true
    @State private var countdownFrom: TimeInterval = UserDefaults.standard.double(forKey: "countdownFrom")
    @State private var player: AVAudioPlayer?
    
    @AppStorage("countdownFrom") private var storedCountdownFrom: Double = 60
    
    let haptic = UINotificationFeedbackGenerator()
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Picker("Mode", selection: $countdownMode) {
                Text("Countdown").tag(true)
                Text("Stopwatch").tag(false)
            }
            .pickerStyle(.segmented)
            .padding()
            .onChange(of: countdownMode) {
                if countdownMode {
                    timeElapsed = 0
                }
            }
            
            Text(timeString)
                .font(.system(size: 50, weight: .bold, design: .monospaced))
                .padding()
                .transition(.opacity)
                .id(timeString)
                .animation(.easeInOut(duration: 0.25), value: timeString)

            HStack(spacing: 30) {
                IconButton(systemName: timerRunning ? "pause.fill" :"play.fill", label: timerRunning ? "Pause" : "Start") {
                    startStop()
                }
                
                IconButton(systemName: "arrow.counterclockwise.circle.fill", label: "Reset") {
                    reset()
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .shadow(radius: 10)
            .foregroundStyle(.white)
            
        }
    }
    
    var timeString: String {
        let displayTime = countdownMode ? max(0, countdownFrom - timeElapsed) : timeElapsed
        return formatTime(displayTime)
    }
    
    func formatTime(_ interval: TimeInterval) -> String {
        let minutes = Int(interval) / 60
        let seconds = Int(interval) % 60
        let milliseconds = Int((interval - floor(interval)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
    
    func startStop() {
        if timerRunning {
            timer?.invalidate()
            timer = nil
        } else {
            if countdownMode && timeElapsed >= countdownFrom {
                timeElapsed = 0
            }
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                if countdownMode {
                    if timeElapsed >= countdownFrom {
                        timer?.invalidate()
                        timer = nil
                        timerRunning = false
                        playSound()
                        haptic.notificationOccurred(.success)
                    } else {
                        timeElapsed += 0.01
                    }
                } else {
                    timeElapsed += 0.01
                }
            }
        }
        timerRunning.toggle()
    }
    
    func reset() {
        
        timer?.invalidate()
        timer = nil
        timeElapsed = 0
        timerRunning = false
        laps.removeAll()
    
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Failed to play sound")
        }
    }
}

#Preview {
   
    StopwatchView()
    
}

