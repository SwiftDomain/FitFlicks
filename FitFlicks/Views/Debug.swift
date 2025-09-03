import SwiftUI

struct FitFlicksTimerView: View {
    @State private var selectedMode: TimerMode = .countdown
    @State private var timeRemaining: Int = 12 // seconds
    @State private var isRunning: Bool = false
    @State private var totalPoints: Int = 500
    
    enum TimerMode: String, CaseIterable {
        case countdown = "Countdown"
        case stopwatch = "Stopwatch"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HeaderView()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Exercise Card
                    ExerciseCard(
                        exerciseName: "Push-Ups",
                        count: 15,
                        points: totalPoints
                    )
                    .padding(.top, 20)
                    
                    // Timer Mode Selector
                    TimerModeSelector(selectedMode: $selectedMode)
                    
                    // Timer Display
                    TimerDisplay(timeRemaining: timeRemaining)
                    
                    // Control Buttons
                    TimerControls(
                        isRunning: $isRunning,
                        onStart: startTimer,
                        onReset: resetTimer
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
            }
        }
        .background(Color(.systemGroupedBackground))
        .ignoresSafeArea(edges: .bottom)
    }
    
    func startTimer() {
        isRunning.toggle()
    }
    
    func resetTimer() {
        timeRemaining = 12
        isRunning = false
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("FitFlicks")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
            
            HStack(spacing: 4) {
                Image(systemName: "flame.fill")
                    .font(.system(size: 14))
                    .foregroundColor(.orange)
                Text("Streak: 0 days")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(
            Color(.systemBackground)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
    }
}

struct ExerciseCard: View {
    let exerciseName: String
    let count: Int
    let points: Int
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(count) \(exerciseName)")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.yellow)
                        Text("\(points) points")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                // Exercise icon
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            colors: [Color.blue.opacity(0.1), Color.blue.opacity(0.2)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: "figure.strengthtraining.traditional")
                        .font(.system(size: 24))
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct TimerModeSelector: View {
    @Binding var selectedMode: FitFlicksTimerView.TimerMode
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(FitFlicksTimerView.TimerMode.allCases, id: \.self) { mode in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedMode = mode
                    }
                }) {
                    Text(mode.rawValue)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(selectedMode == mode ? .white : .secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(
                            Group {
                                if selectedMode == mode {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.blue)
                                } else {
                                    Color.clear
                                }
                            }
                        )
                }
            }
        }
        .padding(4)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(14)
    }
}

struct TimerDisplay: View {
    let timeRemaining: Int
    
    var timeString: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text(timeString)
                .font(.system(size: 72, weight: .thin, design: .monospaced))
                .foregroundColor(.primary)
            
            Text("Ready to start")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

struct TimerControls: View {
    @Binding var isRunning: Bool
    let onStart: () -> Void
    let onReset: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            // Start/Pause Button
            Button(action: onStart) {
                HStack(spacing: 8) {
                    Image(systemName: isRunning ? "pause.fill" : "play.fill")
                        .font(.system(size: 20))
                    Text(isRunning ? "Pause" : "Start")
                        .font(.system(size: 18, weight: .semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    LinearGradient(
                        colors: isRunning ? [Color.orange, Color.red] : [Color.blue, Color.blue.opacity(0.8)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(14)
            }
            
            // Reset Button
            Button(action: onReset) {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
                    .frame(width: 60, height: 60)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(14)
            }
        }
    }
}

// Tab Bar Component
struct QuickFitTabBar: View {
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            
            HStack {
                Spacer()
                
                VStack(spacing: 4) {
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 56, height: 56)
                        
                        Image(systemName: "house.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                    
                    Text("Quick Fit")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.blue)
                }
                
                Spacer()
            }
            .padding(.vertical, 8)
            .background(Color(.systemBackground))
        }
    }
}

// Main App View
struct ContentView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            FitFlicksTimerView()
            
            QuickFitTabBar()
        }
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
