//
//  ScrollingEffectContentView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 9/02/22.
//

// refer https://www.youtube.com/watch?v=LcjI3K78xpI&t=36s

import SwiftUI

struct ScrollingEffectContentView: View {
    @State private var offset: CGFloat = 0
    var topEdge: CGFloat
    
    var body: some View {
        ZStack {
            // Geometry reader for getting hight and width
            GeometryReader { proxy in
                Image("sky")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .ignoresSafeArea()
            // Blur material..
            .overlay(.ultraThinMaterial)
            
            // Main View ...
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    // Weather Data...
                    VStack(alignment: .center, spacing: 5) {
                        Text("San Jose")
                            .font(.system(size: 35))
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                        
                        Text(" 98°")
                            .font(.system(size: 35))
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOpactiy())
                        
                        Text("Cloudy")
                            .foregroundStyle(.secondary)
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOpactiy())
                        
                        Text("H:103° L:105°")
                            .foregroundStyle(.primary)
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOpactiy())
                    }
                    .offset(y: -offset)
                    // For Bottom drag effect ...
                    .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)
                    .offset(y: getTitleOffset())
                    
                    // Custom Data View ...
                    VStack (spacing: 8){
                        // Custom Stack
                        CustomStackView {
                            // Label title
                            Label{
                                Text("Hourly Forecast")
                            } icon: {
                                Image(systemName: "clock")
                            }
                        } contentView: {
                            // Content ...
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    
                                    ForecastView(time: "12 PM", celcius: 94, image: "sun.min")
                                    
                                    ForecastView(time: "1 PM", celcius: 95, image: "sun.haze")
                                    
                                    ForecastView(time: "2 PM", celcius: 96, image: "sun.min")
                                    
                                    ForecastView(time: "3 PM", celcius: 90, image: "cloud.sun")
                                    
                                    ForecastView(time: "4 PM", celcius: 92, image: "sun.haze")
                                    
                                }
                            }
                        }
                        
                        WeatherDataView()
                    }
                }
                .padding(.top, 25)
                .padding(.top, topEdge)
                .padding([.horizontal, .bottom])
                
                // Getting offset
                .overlay(
                    // Using Geometry reader...
                    GeometryReader {proxy -> Color in
                        let minY = proxy.frame(in: .global).minY
                        
                        DispatchQueue.main.async {
                            self.offset = minY
                        }
                        return Color.clear
                    }
                )
            }
        }
    }
    
    func getTitleOpactiy() -> CGFloat {
        let titleOffset = -getTitleOffset()
        let progress = titleOffset / 20
        let opacity = 1 - progress
        return opacity
    }
    
    func getTitleOffset() -> CGFloat {
        // Setting one max height for whole title
        // Consider max as 120
        
        if offset < 0 {
            let progress = offset / 120
            
            // since top padding is 25...
            let newOffset = (progress <= 1.0 ? progress : 1) * 20
            
            return newOffset
        }
        return 0
    }
}

struct ScrollingEffectContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollingEffectRootView()
    }
}

struct ForecastView: View {
    var time: String
    var celcius: CGFloat
    var image: String
    
    var body: some View {
        VStack(spacing: 15) {
            Text(time)
                .font(.callout.bold())
                .foregroundStyle(.white)
            
            Image(systemName: image)
                .font(.title2)
            // MutiColor..
                .symbolVariant(.fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.yellow, .white)
            // max Frame..
                .frame(height: 30)
            
            Text("\(Int(celcius))°")
                .font(.callout.bold())
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 10)
    }
}
