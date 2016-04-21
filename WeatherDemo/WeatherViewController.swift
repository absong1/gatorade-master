//
//  WeatherViewController.swift
//  WeatherDemo
//
//  Created by Alexander Song on 4/19/16.
//  Copyright © 2016 LexCorp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainSwift
import MapKit
import Social

class WeatherViewController: UIViewController, MKMapViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    var zipCodeStr: String?
    var locationManager = CLLocationManager()
    var imagePicker: UIImagePickerController!
    var mapKitHelper = MapKitHelper()
    var socialNetworkHelper = SocialNetworkHelper()

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapInstLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var currentHighLabel: UILabel!
    @IBOutlet weak var currentLowLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cloudinessLabel: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!

    @IBOutlet weak var day1TempLabel: UILabel!
    @IBOutlet weak var day2TempLabel: UILabel!
    @IBOutlet weak var day3TempLabel: UILabel!
    @IBOutlet weak var day4TempLabel: UILabel!
    @IBOutlet weak var day5TempLabel: UILabel!
    
    // MARK: IBActions
    
    @IBAction func cameraBarItem(sender: AnyObject) {
        
        self.imagePicker =  UIImagePickerController()
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func twitterButton(sender: AnyObject) {
        socialNetworkHelper.setupTwitter(self)
    }
    
    @IBAction func sharePhoto(sender: AnyObject) {
        socialNetworkHelper.setupShare(self, userPhoto: userPhoto)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize map and data
        self.mapKitHelper.createMapView(map)
        self.initializeAdditionalStats()
        self.initializeFiveDayForecast()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: 10, height: 10)
    }
    
    // MARK: Class initialization methods
    
    func initializeAdditionalStats() {
    
        if unitTempType == "Farenheit" {
            currentHighLabel.text = "High: \(city.currentHighFStr!)"
        } else {
            currentHighLabel.text = "High: \(city.currentHighCStr!)"
        }
        
        if unitTempType == "Farenheit" {
            currentLowLabel.text = "Low: \(city.currentLowFStr!)"
        } else {
            currentLowLabel.text = "Low: \(city.currentLowCStr!)"
        }
        
        humidityLabel.text = "Humidity: \(city.humidity!)%"
        cloudinessLabel.text = "Cloudiness: \(city.cloudiness!)%"
        
    }
    
    func initializeFiveDayForecast() {
    
        // day1
        if unitTempType == "Farenheit" {
            day1TempLabel.text = "\(city.day1TempFStr!)"
        } else {
            day1TempLabel.text = "\(city.day1TempCStr!)"
        }
        
        // day 2
        if unitTempType == "Farenheit" {
            day2TempLabel.text = "\(city.day2TempFStr!)"
        } else {
            day2TempLabel.text = "\(city.day2TempCStr!)"
        }
        
        // day 3
        if unitTempType == "Farenheit" {
            day3TempLabel.text = "\(city.day3TempFStr!)"
        } else {
            day3TempLabel.text = "\(city.day3TempCStr!)"
        }
        
        // day 4
        if unitTempType == "Farenheit" {
            day4TempLabel.text = "\(city.day4TempFStr!)"
        } else {
            day4TempLabel.text = "\(city.day4TempCStr!)"
        }
        
        // day 5
        if unitTempType == "Farenheit" {
            day5TempLabel.text = "\(city.day5TempFStr!)"
        } else {
            day5TempLabel.text = "\(city.day5TempCStr!)"
        }
    
    }
    
    // MARK: Image Picker Controller Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
        // set user taken photo to the uiview
        userPhoto.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        // Access the uncropped image from info dictionary
        let imageToSave: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
        
        self.savedImageAlert(self)
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
