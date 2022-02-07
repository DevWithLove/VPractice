//
//  ProgressRing.swift
//  VacasaPractice
//
//  Created by Tony Mu on 7/02/22.
//

import SwiftUI

struct ProgressRing: View {
    @EnvironmentObject var fastingManager: FastingManager
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
             // MARK: Placeholder Ring
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)
            
            // MARK: Colored Ring
            Circle()
                .trim(from: 0.0, to: min(
                    fastingManager.progress, 1.0))
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2863707542, green: 0.5344309807, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.9448934197, green: 0.2673981786, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.71397084, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.5684384108, green: 0.9592099786, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.3730742633, green: 0.4826079607, blue: 1, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeOut(duration: 1.0), value: fastingManager.progress)
            
            VStack(spacing: 30) {
                if fastingManager.fastingState == .notStarted {
                    // MARK: Upcoming fast
                    VStack(spacing: 5) {
                        Text("Upcoming fast")
                            .opacity(0.7)
                        Text("\(fastingManager.fastingPlan.fastingPeriod.formatted()) Hours")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding(.top, 10)
                } else {
                    // MARK: Elapsed Time
                    
                    VStack(spacing: 5) {
                        Text("Elapsed time (\(fastingManager.progress.formatted(.percent))")
                            .opacity(0.7)
                        Text(fastingManager.startTime, style: .timer)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding(.top, 10)
                    
                    // MARK: Remaining time
                    VStack(spacing: 5) {
                        if !fastingManager.elapsed {
                            Text("Remaining time (\( (1-fastingManager.progress).formatted(.percent)))")
                                .opacity(0.7)
                        } else {
                            Text("Extra time")
                                .opacity(0.7)
                        }
                 
                        Text(fastingManager.endTime, style: .timer)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
            }
        }
        .frame(width: 250, height: 250)
        .padding()
        .onReceive(timer) { _ in
            fastingManager.track()
        }
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing()
            .environmentObject(FastingManager())
    }
}
