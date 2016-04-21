//
//  GetWeatherHelper.swift
//  WeatherDemo
//
//  Created by Alexander Song on 4/19/16.
//  Copyright © 2016 LexCorp. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import KeychainSwift

var city = City()

class WeatherDataHelper {

    func getWeatherData(zipcode: String?, completionHandler: (() -> Void)!) {
        
        if zipcode != nil {
            
            let keychain = KeychainSwift()
            
            Alamofire.request(.GET, "http://api.openweathermap.org/data/2.5/weather?zip=\(zipcode!),us&appid=\(keychain.get("apikey")!)")
                .response { request, response, data, error in
                    let json = JSON(data: data!)
                    
                    //get city name
                    if let name = json["name"].string {
                        print("city name: \(name)")
                        city.name = name
                    } else {
                        //Print the error
                        print(json["name"].error?.localizedDescription)
                    }
                    
                    //get location
                    //get latitutde
                    if let latitude = json["coord"]["lat"].double {
                        print("latitude: \(latitude)")
                        city.location.updateValue(latitude, forKey:"latitude")
                    } else {
                        //Print the error
                        print(json["coord"]["lat"].error?.localizedDescription)
                    }
                    //get longitude
                    if let longitude = json["coord"]["lon"].double {
                        print("longitude: \(longitude)")
                        city.location.updateValue(longitude, forKey:"longitude")
                    } else {
                        //Print the error
                        print(json["coord"]["lon"].error?.localizedDescription)
                    }
                    
                    //get current temperature
                    if let currentTemperature = json["main"]["temp"].double {
                        print("current temp k: \(currentTemperature)")
                        city.currentTemperature = currentTemperature
                        
                        //make temperature unit conversions
                        city.convertFarenheit(city.currentTemperature!, reading: "current")
                        city.convertCelcius(city.currentTemperature!, reading: "current")
                        print("current temp f: \(city.currentTempFStr!)")
                        print("current temp c: \(city.currentTempCStr!)")
                    } else {
                        //Print the error
                        print(json["main"]["temp"].error)
                    }
                    
                    //get high current temperature
                    if let currentHigh = json["main"]["temp_max"].double {
                        print("print: \(currentHigh)")
                        city.currentHigh = currentHigh
                        
                        //make temperature unit conversions
                        city.convertFarenheit(city.currentHigh!, reading: "high")
                        city.convertCelcius(city.currentHigh!, reading: "high")
                        print("current temp f: \(city.currentHighFStr!)")
                        print("current temp c: \(city.currentHighCStr!)")
                    } else {
                        //Print the error
                        print(json["main"]["temp_max"].error)
                    }
                    
                    //get low current temperature
                    if let currentLow = json["main"]["temp_min"].double {
                        print("current low: \(currentLow)")
                        city.currentLow = currentLow
                        
                        //make temperature unit conversions
                        city.convertFarenheit(city.currentLow!, reading: "low")
                        city.convertCelcius(city.currentLow!, reading: "low")
                        print("current temp f: \(city.currentLowFStr!)")
                        print("current temp c: \(city.currentLowCStr!)")
                    } else {
                        //Print the error
                        print(json["main"]["temp_min"].error)
                    }
                    
                    //get humidity
                    if let humidity = json["main"]["humidity"].double {
                        print("humidity: \(humidity)")
                        city.humidity = String(humidity)
                    } else {
                        //Print the error
                        print(json["main"]["humidity"].error)
                    }
                    
                    //get cloudiness
                    if let cloudiness = json["clouds"]["all"].double {
                        print("cloudiness: \(cloudiness)")
                        city.cloudiness = String(cloudiness)
                        completionHandler()
                    } else {
                        //Print the error
                        print(json["main"]["all"].error)
                        completionHandler()
                    }
                    
                    
            }
        }
        else {
            print("Invalid ZIP Code")
        }
        
    }
    
    func getFiveDayForecast(zipcode: String?, completionHandler: (() -> Void)!) {
        
        if zipcode != nil {
            
            let keychain = KeychainSwift()
            
            Alamofire.request(.GET, "http://api.openweathermap.org/data/2.5/forecast/daily?zip=\(zipcode!),us&appid=\(keychain.get("apikey")!)")
                .response { request, response, data, error in
                    let json = JSON(data: data!)
                    print(json)
                    
                    // get day 1 temperature
                    if let day1Temp = json["list"][0]["temp"]["day"].double {
                        print("day 1 temp k: \(day1Temp)")
                        city.day1Temperature = day1Temp
                        
                        //make temperature unit conversions
                        city.convertFarenheit(city.day1Temperature!, reading: "day1")
                        city.convertCelcius(city.day1Temperature!, reading: "day1")
                        print("day 1 temp f: \(city.day1TempFStr!)")
                        print("day 1 temp c: \(city.day1TempCStr!)")
                    } else {
                        //Print the error
                        print(json["list"][0]["temp"]["day"].error)
                    }

                    // get day 2 temperature
                    if let day2Temp = json["list"][1]["temp"]["day"].double {
                        print("day 2 temp k: \(day2Temp)")
                        city.day2Temperature = day2Temp
                        
                        //make temperature unit conversions
                        city.convertFarenheit(city.day2Temperature!, reading: "day2")
                        city.convertCelcius(city.day2Temperature!, reading: "day2")
                        print("day 2 temp f: \(city.day2Temperature!)")
                        print("day 2 temp c: \(city.day2Temperature!)")
                    } else {
                        //Print the error
                        print(json["list"][1]["temp"]["day"].error)
                    }
                    
                    // get day 3 temperature
                    if let day3Temp = json["list"][2]["temp"]["day"].double {
                        print("day 3 temp k: \(day3Temp)")
                        city.day3Temperature = day3Temp
                        
                        //make temperature unit conversions
                        city.convertFarenheit(city.day3Temperature!, reading: "day3")
                        city.convertCelcius(city.day3Temperature!, reading: "day3")
                        print("day 3 temp f: \(city.day3TempFStr!)")
                        print("day 3 temp c: \(city.day3TempCStr!)")
                    } else {
                        //Print the error
                        print(json["list"][2]["temp"]["day"].error)
                    }
                    
                    // get day 4 temperature
                    if let day4Temp = json["list"][3]["temp"]["day"].double {
                        print("day 4 temp k: \(day4Temp)")
                        city.day4Temperature = day4Temp
                        
                        //make temperature unit conversions
                        city.convertFarenheit(city.day4Temperature!, reading: "day4")
                        city.convertCelcius(city.day4Temperature!, reading: "day4")
                        print("day 4 temp f: \(city.day4TempFStr!)")
                        print("day 4 temp c: \(city.day4TempCStr!)")
                    } else {
                        //Print the error
                        print(json["list"][3]["temp"]["day"].error)
                    }
                    
                    // get day 5 temperature
                    if let day5Temp = json["list"][4]["temp"]["day"].double {
                        print("day 5 temp k: \(day5Temp)")
                        city.day5Temperature = day5Temp
                        
                        //make temperature unit conversions
                        city.convertFarenheit(city.day5Temperature!, reading: "day5")
                        city.convertCelcius(city.day5Temperature!, reading: "day5")
                        print("day 5 temp f: \(city.day5TempFStr!)")
                        print("day 5 temp c: \(city.day5TempCStr!)")
                        completionHandler()
                    } else {
                        //Print the error
                        print(json["list"][4]["temp"]["day"].error)
                        completionHandler()
                    }
                    
            }
        }
        else {
            print("Invalid ZIP Code")
        }

        
    }
    
}