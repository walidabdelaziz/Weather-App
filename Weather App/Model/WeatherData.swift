//
//  WeatherData.swift
//  Weather App
//
//  Created by Walid  on 7/8/20.
//  Copyright © 2020 Walid . All rights reserved.
//

import Foundation
struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}
struct Main: Decodable{
    let temp: Double
}

struct Weather: Decodable {
    let id :Int
}
