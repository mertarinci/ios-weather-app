//
//  WeatherModel.swift
//  Clima
//
//  Created by Mert Arinci on 9/24/22.

import Foundation

struct WeatherModel {
    let weatherId : Int
    let cityName : String
    let temperature : Double
    
    var oneDecimalTemp : String {
        String(format: "%.1f", temperature)
    }
    
    var conditionName : String {
        
        if ((200...233).contains(weatherId)){
            return "cloud.bolt.rain"
        }else if ((300...322).contains(weatherId)){
            return "cloud.drizzle"
        }else if((500...532).contains(weatherId)){
            return "cloud.rain"
        }else if((600...623).contains(weatherId)){
            return "cloud.snow"
        }else if((700...782).contains(weatherId)){
            return "cloud.fog"
        }else if(weatherId == 800){
            return "sun.max"
        }else if((801...805).contains(weatherId)){
            return "cloud"
        }else{
            return "cloud"
        }
    }
}
