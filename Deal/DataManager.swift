//
//  DataManager.swift
//  Deal
//
//  Created by Do Kwon on 4/24/15.
//  Copyright (c) 2015 Ki Suk Jang. All rights reserved.
//

import Foundation


class DataManager {
    
    /* Cached version */
    //var deals : [NSManagedObject]
    var deals : [Deal]
    var deal_users : [String : User]
    var my_id : String
    
    var cur_user : User?
    
    init () {
        self.deals = [Deal]()
        self.deal_users = Dictionary<String, User>()
        self.my_id = "hv8I0APXIL"
    }
    
    
    /*func fetchDeals (appDelegate : AppDelegate) {
    
    let managedContext = appDelegate.managedObjectContext!
    
    //2
    let fetchRequest = NSFetchRequest(entityName:"Deal")
    
    //3
    var error: NSError?
    
    let fetchedResults =
    managedContext.executeFetchRequest(fetchRequest,
    error: &error) as! [NSManagedObject]?
    
    if let results = fetchedResults {
    deals = results
    } else {
    println("Could not fetch \(error), \(error!.userInfo)")
    }
    
    }*/
    
    
    
    func getDealForIndex (index : Int) ->Deal {
        //println (String(deals))
        var deal_obj = deals [index]
        /*let type_int = Deal.int_to_type(deal_obj.valueForKey("type") as! Int)
        var deal = Deal(task: deal_obj.valueForKey("task") as! String,
        reward: deal_obj.valueForKey("reward") as! String, deal_type: type_int)*/
        return deal_obj
    }
    
    func saveDeal(deal : Deal) {
        //func saveDeal(deal : Deal, appDelegate : AppDelegate) {
        /*let managedContext = appDelegate.managedObjectContext!
        
        //2
        let entity =  NSEntityDescription.entityForName("Deal",
        inManagedObjectContext:
        managedContext)
        
        let deal_obj = NSManagedObject(entity: entity!,
        insertIntoManagedObjectContext:managedContext)
        
        //3
        deal_obj.setValue(deal.task, forKey: "task")
        deal_obj.setValue(deal.reward, forKey: "reward")
        deal_obj.setValue(Deal.type_to_int(deal.deal_type), forKey: "type")
        deal_obj.setValue(deal.complete, forKey: "completed")
        
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
        println("Could not save \(error), \(error?.userInfo)")
        }
        //5
        deals.append(deal_obj)
        */
        deals.append(deal)
    }
    
    
}