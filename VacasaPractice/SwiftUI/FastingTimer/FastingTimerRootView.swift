//
//  FastingTimerRootView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 7/02/22.
//

// Refer to https://www.youtube.com/watch?v=pdYTtbOl9YQ

import SwiftUI

struct FastingTimerRootView: View {
    @StateObject var fastingManager = FastingManager()
    
    var title: String {
        switch fastingManager.fastingState {
        case .notStarted:
            return "Let's get started!"
        case .fasting:
            return "You are now fasting"
        case .feeding:
            return "You are now feeding"
        }
    }
    
    var body: some View {
        ZStack {
            
            // MARK: Backgournd
            // Go to Edit, Format -> Show Colors to pick color, pick a color and drag drop the color into the color init
            Color(#colorLiteral(red: 0.04420081526, green: 0, blue: 0.0760954842, alpha: 1))
                .ignoresSafeArea(edges: .top)
            content
        }
    }
    
    var content: some View {
        ZStack {
            VStack(spacing: 40) {
                // MARK: Title
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color(#colorLiteral(red: 0.2863707542, green: 0.5344309807, blue: 1, alpha: 1)))
                
                // MARK: Fasting plan
                Text(fastingManager.fastingPlan.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                Spacer()
            }.padding()
            
            VStack(spacing: 40) {
                // MARK: Progress ring
                ProgressRing()
                    .environmentObject(fastingManager)
            
                HStack(spacing: 60) {
                    // MARK: Start time
                    VStack(spacing: 5) {
                        Text(fastingManager.fastingState == .notStarted ? "Start" : "Started")
                            .opacity(0.7)
                        
                        Text(fastingManager.startTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                    
                    // MARK: End time
                    VStack(spacing: 5) {
                        Text(fastingManager.fastingState == .notStarted ? "End" : "Ends")
                            .opacity(0.7)
                        
                        Text(fastingManager.endTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                }
                
                // MARK: Button
                Button{
                    fastingManager.toggleFastingState()
                } label: {
                    Text(fastingManager.fastingState == .fasting ? "End fast" : "Start fasting")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                }
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct FastingTimerRootView_Previews: PreviewProvider {
    static var previews: some View {
        FastingTimerRootView()
    }
}
