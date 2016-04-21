//
//  CoreDataHelper.swift
//  WeatherDemo
//
//  Created by Alexander Song on 4/20/16.
//  Copyright © 2016 LexCorp. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
let context: NSManagedObjectContext = appDel.managedObjectContext

class CoreDataHelper {
    
    func saveLocationToDB(location: String) {
        
        let newUser =  NSEntityDescription.insertNewObjectForEntityForName("Locations", inManagedObjectContext: context)
        
        newUser.setValue("\(location)", forKey: "zipcode")
        
        do {
            try context.save()
        } catch {
            print("Problem saving to DB...")
        }
        
    }
    
    func deleteObjectFromDB(entity: String, objectToDelete: String) {
        
        let request = NSFetchRequest(entityName: entity)
        
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.executeFetchRequest(request)
            for managedObject in results
            {
                print(managedObject.valueForKey("zipcode")!)
                if objectToDelete == managedObject.valueForKey("zipcode")! as! String {
                    let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                    context.deleteObject(managedObjectData)
                }
            }
        } catch let error as NSError {
            print("Delete  in \(entity) error : \(error) \(error.userInfo)")
        }
        
    }
    
    func fetchLocationsFromDB(entity: String) {
        
        let request = NSFetchRequest(entityName: entity)
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.executeFetchRequest(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    print("Database Results: \(result.valueForKey("zipcode")!)")
                    zipCodeArr.append(result.valueForKey("zipcode")! as! String)
                }
            }
        } catch {
            print("Fetch failed...")
        }
        
    }
    
    //MARK: Testing Functions
    
    func deleteDB(entity: String) {
        
        let request = NSFetchRequest(entityName: entity)
        
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.executeFetchRequest(request)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                context.deleteObject(managedObjectData)
            }
        } catch let error as NSError {
            print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
        }
        
    }
    

}