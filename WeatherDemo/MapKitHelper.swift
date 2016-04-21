//
//  MapKitHelper.swift
//  WeatherDemo
//
//  Created by TUtu on 4/20/16.
//  Copyright © 2016 LexCorp. All rights reserved.
//

import Foundation
import MapKit

class MapKitHelper {

    func createMapView(map: MKMapView!) {
        //initialize map view
        let latitude: CLLocationDegrees = city.location["latitude"]!
        print("lat: \(latitude)")
        let longitude: CLLocationDegrees = city.location["longitude"]!
        print("lon: \(longitude)")
        let latDelta: CLLocationDegrees = 0.01
        let lonDelta: CLLocationDegrees = 0.01
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = city.name
        if unitTempType == "Farenheit" {
        annotation.subtitle = "Current temperature: \(city.currentTempFStr!)"
        } else {
        annotation.subtitle = "Current temperature: \(city.currentTempCStr!)"
        }
        map.addAnnotation(annotation)
    }

}
