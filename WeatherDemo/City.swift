//
//  Model.swift
//  WeatherDemo
//
//  Created by Alexander Song on 4/19/16.
//  Copyright © 2016 LexCorp. All rights reserved.
//

import Foundation

struct City {
    
    var name: String?
    var location: [String: Double] = [
        "latitude: ": 0.0,
        "longitude: ": 0.0
    ]
    
    // main data vars
    var currentTemperature: Double?
    var currentTempFStr: String?
    var currentTempCStr: String?
    
    var currentHigh: Double?
    var currentHighFStr: String?
    var currentHighCStr: String?
    
    var currentLow: Double?
    var currentLowFStr: String?
    var currentLowCStr: String?
    
    var cloudiness: String?
    var humidity: String?
    
    // 5 day forecast vars
    var day1Temperature: Double?
    var day1TempFStr: String?
    var day1TempCStr: String?
    
    var day2Temperature: Double?
    var day2TempFStr: String?
    var day2TempCStr: String?
    
    var day3Temperature: Double?
    var day3TempFStr: String?
    var day3TempCStr: String?
    
    var day4Temperature: Double?
    var day4TempFStr: String?
    var day4TempCStr: String?
    
    var day5Temperature: Double?
    var day5TempFStr: String?
    var day5TempCStr: String?
    
    mutating func convertCelcius (kelvins: Double, reading: String) {
        
        switch reading {
            
        case "current":
            let currentTempC = currentTemperature! - 273.15
            currentTempCStr = String(currentTempC.roundToPlaces(1)) + "℃"
            
        case "high":
            let currentHighC = currentHigh! - 273.15
            currentHighCStr = String(currentHighC.roundToPlaces(1)) + "℃"
            
        case "low":
            let currentLowC = currentLow! - 273.15
            currentLowCStr = String(currentLowC.roundToPlaces(1)) + "℃"
            
        case "day1":
            let day1TempC = day1Temperature! - 273.15
            day1TempCStr = String(day1TempC.roundToPlaces(1)) + "℃"
            
        case "day2":
            let day2TempC = day2Temperature! - 273.15
            day2TempCStr = String(day2TempC.roundToPlaces(1)) + "℃"
            
        case "day3":
            let day3TempC = day3Temperature! - 273.15
            day3TempCStr = String(day3TempC.roundToPlaces(1)) + "℃"
            
        case "day4":
            let day4TempC = day4Temperature! - 273.15
            day4TempCStr = String(day4TempC.roundToPlaces(1)) + "℃"
            
        case "day5":
            let day5TempC = day5Temperature! - 273.15
            day5TempCStr = String(day5TempC.roundToPlaces(1)) + "℃"
            
        default:
            break
            
        }
        
    }
    
    mutating func convertFarenheit (kelvins: Double, reading: String) {

        switch reading {
        
        case "current":
            let currentTempF = ((currentTemperature!*9)/5) - 459.67
            currentTempFStr = String(currentTempF.roundToPlaces(1)) + "℉"

        case "high":
            let currentHighF = ((currentHigh!*9)/5) - 459.67
            currentHighFStr = String(currentHighF.roundToPlaces(1)) + "℉"
        
        case "low":
            let currentLowF = ((currentLow!*9)/5) - 459.67
            currentLowFStr = String(currentLowF.roundToPlaces(1)) + "℉"
            
        case "day1":
            let day1TempF = ((day1Temperature!*9)/5) - 459.67
            day1TempFStr = String(day1TempF.roundToPlaces(1)) + "℉"
            
        case "day2":
            let day2TempF = ((day2Temperature!*9)/5) - 459.67
            day2TempFStr = String(day2TempF.roundToPlaces(1)) + "℉"
            
        case "day3":
            let day3TempF = ((day3Temperature!*9)/5) - 459.67
            day3TempFStr = String(day3TempF.roundToPlaces(1)) + "℉"
            
        case "day4":
            let day4TempF = ((day4Temperature!*9)/5) - 459.67
            day4TempFStr = String(day4TempF.roundToPlaces(1)) + "℉"
            
        case "day5":
            let day5TempF = ((day5Temperature!*9)/5) - 459.67
            day5TempFStr = String(day5TempF.roundToPlaces(1)) + "℉"

        default:
            break

        }
        
    }
    
}

//MARK: Extensions

extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}