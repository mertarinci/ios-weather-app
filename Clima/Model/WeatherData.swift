//
//  WeatherData.swift
//  Clima
//
//  Created by Mert Arinci on 9/24/22

import Foundation

struct WeatherData: Decodable {

    let name : String
    let main : Main
    let weather : [Weather]
    
}

struct Main : Decodable {
    let temp : Double
}

struct Weather : Decodable {
    let id : Int
}
