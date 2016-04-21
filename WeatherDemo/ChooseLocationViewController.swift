//
//  ChooseLocationViewController.swift
//  WeatherDemo
//
//  Created by Alexander Song on 4/19/16.
//  Copyright © 2016 LexCorp. All rights reserved.
//

import UIKit
import CoreData
import KeychainSwift
import MapKit
import CoreLocation

var unitTempType: String = "Farenheit"
var zipCodeArr = [String]()

class ChooseLocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    var newCityAlertView: UIAlertController!
    var selectedIndexPath: NSIndexPath?
    let keychain = KeychainSwift()
    var weatherDataHelper = WeatherDataHelper()
    var coreLocationHelper = CoreLocationHelper()
    var coreDataHelper = CoreDataHelper()

    var locationManager = CLLocationManager()

    
    @IBOutlet weak var cityListTableView: UITableView!
    @IBOutlet weak var addNewCityBtn: UIBarButtonItem!
    @IBOutlet weak var unitConversionSwitch: UISwitch!
    
    @IBAction func getDataByUsersLocation(sender: AnyObject) {
        
        self.coreLocationHelper.convertLocationToZIP {
            print("zip converted!")
            self.cityListTableView.reloadData()
        }
    }
    
    // MARK: IBAction
    
    @IBAction func addNewCityBtn(sender: AnyObject) {
        
        newCityAlertView = UIAlertController(title: "Zip Code?", message: "Please enter a valid zip code:", preferredStyle: .Alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .Default) { (_) in
            if let field = self.newCityAlertView.textFields![0] as? UITextField {
                // store your data
                zipCodeArr.append(field.text!)
                self.coreDataHelper.saveLocationToDB(field.text!)
                
                self.cityListTableView.reloadData()
                
            } else {
                // user did not fill field
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        newCityAlertView.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Enter Zip Code"
        }
        
        newCityAlertView.addAction(confirmAction)
        newCityAlertView.addAction(cancelAction)
        
        self.presentViewController(newCityAlertView, animated: true, completion: nil)
        
    }
    @IBAction func unitConversionSwitch(sender: AnyObject) {
        if unitConversionSwitch.on {
            unitTempType = "Farenheit"
        } else {
            unitTempType = "Celcius"
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // test code to delete key
        //keychain.clear()
        
        // test code to delete DB
        //coreDataHelper.deleteDB("Locations")
        
        // set tableview delegate and datasource
        self.cityListTableView.delegate = self
        self.cityListTableView.dataSource = self
        
        // set core location manager and delegate
        self.locationManager.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // fetch locations data from database
        self.coreDataHelper.fetchLocationsFromDB("Locations")
        print("Elements loaded to arr from DB: \(zipCodeArr)")
        
        // if API key not yet saved do so in keychain
        if keychain.get("apikey") == nil {
            let API_KEY: String = "36138b6dd9119c7963fc6a56040e88e8"
            keychain.set(API_KEY, forKey: "apikey")
        } else {
            return
        }
        
    }
    
    // MARK: CLLocationManager Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocationCoordinate2D = manager.location!.coordinate
        userLat = location.latitude
        userLon = location.longitude
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        // Delegate of the location manager, when you have an error
        print("didFailWithError: \(error)");
        
        self.updateLocationFailedAlert(self)
    }
    
    // MARK: Tableview Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zipCodeArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = cityListTableView.dequeueReusableCellWithIdentifier("ZipCodeCell") as UITableViewCell!
        cell?.textLabel?.text = zipCodeArr[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = indexPath
        self.weatherDataHelper.getWeatherData(zipCodeArr[indexPath.row], completionHandler: {
            self.weatherDataHelper.getFiveDayForecast(zipCodeArr[indexPath.row], completionHandler: {
                print("finished getting data!")
                self.performSegueWithIdentifier("WeatherViewSegue", sender: self)
            })
        })
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // delete from DB
            coreDataHelper.deleteObjectFromDB("Locations", objectToDelete: zipCodeArr[indexPath.row])
            // delete from temp arr
            zipCodeArr.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "WeatherViewSegue" {
            let destinationVC = segue.destinationViewController as! WeatherViewController
            
            destinationVC.title = zipCodeArr[(selectedIndexPath?.row)!]
            destinationVC.zipCodeStr = zipCodeArr[(selectedIndexPath?.row)!]
        }
    }
    
    
}
