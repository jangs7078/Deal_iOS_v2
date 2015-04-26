//
//  ParseDBService.swift
//  Deal
//
//  Created by Ki Suk Jang on 4/25/15.
//  Copyright (c) 2015 Ki Suk Jang. All rights reserved.
//

import Foundation

class ParseDBService {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    func createUser(phone_num : String, first_name : String, last_name : String) {
        let params = NSMutableDictionary()
        params.setObject(phone_num, forKey: "Phone_Num" )
        params.setObject(first_name, forKey: "First_Name" )
        params.setObject(last_name, forKey: "Last_Name" )
        PFCloud.callFunctionInBackground("createUser", withParameters: params as [NSObject : AnyObject], block: {
                (result: AnyObject?, error: NSError?) -> Void in
                if ( error == nil) {
                    NSLog("success: \(result) ")
                }
                else if (error != nil) {
                    NSLog("error: \(error!.userInfo)")
                }
        })
    }
    
    func updateUser(first_name : String, last_name : String) {
        let params = NSMutableDictionary()
        params.setObject(appDelegate.deal_data_manager!.my_id, forKey: "objectId" )
        params.setObject(first_name, forKey: "First_Name" )
        params.setObject(last_name, forKey: "Last_Name" )
        PFCloud.callFunctionInBackground("updateUser", withParameters: params as [NSObject : AnyObject], block: {
            (result: AnyObject?, error: NSError?) -> Void in
            if ( error == nil) {
                NSLog("success: \(result) ")
            }
            else if (error != nil) {
                NSLog("error: \(error!.userInfo)")
            }
        })
    }
    
    func deleteUser(){
        let params = NSMutableDictionary()
        params.setObject(appDelegate.deal_data_manager!.my_id, forKey: "objectId" )
        PFCloud.callFunctionInBackground("deleteUser", withParameters: params as [NSObject : AnyObject], block: {
            (result: AnyObject?, error: NSError?) -> Void in
            if ( error == nil) {
                NSLog("success: \(result) ")
            }
            else if (error != nil) {
                NSLog("error: \(error!.userInfo)")
            }
        })
    }
    
    func addFriends(contact_list: [String]){
        let params = NSMutableDictionary()
        params.setObject(appDelegate.deal_data_manager!.my_id, forKey: "objectId" )
        params.setObject(contact_list, forKey: "List_Of_Contacts" )
        PFCloud.callFunctionInBackground("addFriends", withParameters: params as [NSObject : AnyObject], block: {
            (result: AnyObject?, error: NSError?) -> Void in
            if ( error == nil) {
                NSLog("success: \(result) ")
            }
            else if (error != nil) {
                NSLog("error: \(error!.userInfo)")
            }
        })
    }
    
    func getFriends(){
        let params = NSMutableDictionary()
        params.setObject(appDelegate.deal_data_manager!.my_id, forKey: "objectId" )
        PFCloud.callFunctionInBackground("getFriends", withParameters: params as [NSObject : AnyObject], block: {
            (result: AnyObject?, error: NSError?) -> Void in
            if ( error == nil) {
                NSLog("success: \(result) ")
            }
            else if (error != nil) {
                NSLog("error: \(error!.userInfo)")
            }
        })
    }
    
    func createDeal(dealee_id: String, task: String, reward: String){
        let params = NSMutableDictionary()
        params.setObject(appDelegate.deal_data_manager!.my_id, forKey: "Dealer_Id" )
        params.setObject(dealee_id, forKey: "Dealee_Id" )
        params.setObject(task, forKey: "Task" )
        params.setObject(reward, forKey: "Reward" )
        PFCloud.callFunctionInBackground("createDeal", withParameters: params as [NSObject : AnyObject], block: {
            (result: AnyObject?, error: NSError?) -> Void in
            if ( error == nil) {
                NSLog("success: \(result) ")
            }
            else if (error != nil) {
                NSLog("error: \(error!.userInfo)")
            }
        })
    }
}