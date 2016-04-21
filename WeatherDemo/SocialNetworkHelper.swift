//
//  SocialNetworkHelper.swift
//  WeatherDemo
//
//  Created by TUtu on 4/20/16.
//  Copyright © 2016 LexCorp. All rights reserved.
//

import UIKit
import Social

class SocialNetworkHelper {
    
    func setupTwitter(viewController: UIViewController) {
    
        let shareToTwitter: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        viewController.presentViewController(shareToTwitter, animated: true, completion: nil)
    
    }
    
    func setupShare(viewController: UIViewController, userPhoto: UIImageView) {
    
        let actionSheet = UIAlertController(title: "", message: "Share your Note", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        // Configure a new action to share on Facebook.
        let facebookPostAction = UIAlertAction(title: "Share on Facebook", style: UIAlertActionStyle.Default) { (action) -> Void in
            
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                let facebookComposeVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookComposeVC.addImage(userPhoto.image)
                viewController.presentViewController(facebookComposeVC, animated: true, completion: nil)
            }
            else {
                viewController.showAlertMessage("You are not connected to your Facebook account.", viewController: viewController)
            }
            
        }
        
        // Configure a new action to show the UIActivityViewController
        let moreAction = UIAlertAction(title: "More", style: UIAlertActionStyle.Default) { (action) -> Void in
            
            let activityViewController = UIActivityViewController(activityItems: [userPhoto.image!], applicationActivities: nil)
            
            activityViewController.excludedActivityTypes = [UIActivityTypeMail]
            
            viewController.presentViewController(activityViewController, animated: true, completion: nil)
            
        }
        
        
        let dismissAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            
        }
        
        actionSheet.addAction(facebookPostAction)
        actionSheet.addAction(moreAction)
        actionSheet.addAction(dismissAction)
        
        viewController.presentViewController(actionSheet, animated: true, completion: nil)
    
    }

}