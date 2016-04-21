//
//  AlertViewHelper.swift
//  WeatherDemo
//
//  Created by TUtu on 4/20/16.
//  Copyright © 2016 LexCorp. All rights reserved.
//

import UIKit

extension UIViewController {

    func updateLocationFailedAlert(viewController: UIViewController)
    {
        let alertController = UIAlertController(title: "Update Location Failure", message: "User location failed to update.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func savedImageAlert(viewController: UIViewController)
    {
        let alertController = UIAlertController(title: "Saved!", message: "Your picture was saved to Camera Roll", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showAlertMessage(message: String!, viewController: UIViewController) {
        let alertController = UIAlertController(title: "EasyShare", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }

}