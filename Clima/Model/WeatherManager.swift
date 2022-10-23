//
//  WeatherManager.swift
//  Clima
//
//  Created by Mert Arinci on 9/24/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error : Error)
}



struct WeatherManager {
    
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=08aa5163c1faf50a568b2084ab6d5216&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(latitude : CLLocationDegrees, longtitude : CLLocationDegrees){
        
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longtitude)"
        performRequest(with: urlString)
        
    }
    
    func fetchWeather(city : String){
        
        
        let urlString = "\(weatherURL)&q=\(city)"
        performRequest(with: urlString)
        
    }
    
    
    func performRequest(with urlString : String){
        
        // 1. Create URL
        if let url = URL(string: urlString) {
            
            // 2. Create a URL Session
            
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    
                    if let weather = self.parseJSON(safeData) {
                        delegate?.didUpdateWeather(self,weather : weather)
                        
                    }
                }
            }
            
            // 4. Start the task
            
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData : Data) -> WeatherModel?{
        let decoder = JSONDecoder()
       
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(weatherId: id, cityName: name, temperature: temp)
            
            return weather
            
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
}
