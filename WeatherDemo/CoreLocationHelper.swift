//
//  CoreLocationHelper.swift
//  WeatherDemo
//
//  Created by TUtu on 4/20/16.
//  Copyright © 2016 LexCorp. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

var userLat: Double = 0.0
var userLon: Double = 0.0

class CoreLocationHelper {
    
    var coreDataHelper = CoreDataHelper()

    func convertLocationToZIP(completionHandler: (() -> Void)!) {
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: userLat, longitude: userLon)
        
        print(location)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            print(placeMark.addressDictionary!["ZIP"])
            
            // zip code
            if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                
                // save to array
                zipCodeArr.append(zip as String)
                // save to datbase
                self.coreDataHelper.saveLocationToDB(zip as String)
                
                print(zipCodeArr)
                completionHandler()
            }
            
            if error != nil {
                print(error?.localizedDescription)
                completionHandler()
            }
            
            
        })
    }
}