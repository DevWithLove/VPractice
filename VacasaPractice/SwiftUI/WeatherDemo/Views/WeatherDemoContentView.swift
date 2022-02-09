//
//  WeatherDemoContentView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 8/02/22.
//

import SwiftUI

struct WeatherDemoContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather : WeatherResponseBody?
    var body: some View {
        VStack {
            
            if let location = locationManager.location {
                if let weather = weather {
                    ScrollView {
                        WeatherView(weather: weather)
                    }
                } else {
                    LoadingView()
                        .task {
                            do {
                              weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct WeatherDemoContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDemoContentView()
    }
}
