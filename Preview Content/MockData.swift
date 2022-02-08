//
//  MockData.swift
//  VacasaPractice
//
//  Created by Tony Mu on 19/01/22.
//

import Foundation

extension RepositorySearchResultDto {
    static var mockRepositorySearchResultDto: RepositorySearchResultDto {
        Bundle.main.decode(RepositorySearchResultDto.self, from: "searchRepository.json")
    }
}

extension Hike {
    static var mockHikes: [Hike] {
        Bundle.main.decode([Hike].self, from: "hikeData.json")
    }
}

extension Landmark {
    static var mockData: [Landmark] {
        Bundle.main.decode([Landmark].self, from: "landmarkData.json")
    }
}

extension WeatherResponseBody {
    static var mock: WeatherResponseBody {
        Bundle.main.decode(WeatherResponseBody.self, from: "weatherData.json")
    }
}
