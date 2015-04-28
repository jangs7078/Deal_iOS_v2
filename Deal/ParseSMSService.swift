//
//  ParseSMSService.swift
//  Deal
//
//  Created by Ki Suk Jang on 4/25/15.
//  Copyright (c) 2015 Ki Suk Jang. All rights reserved.
//

import Foundation

class ParseSMSService {

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    func getVerificationCode(my_num : String) -> Bool {
        let params = NSMutableDictionary()
        params.setObject(appDelegate.deal_data_manager!.my_id, forKey: "objectId" )
        PFCloud.callFunctionInBackground("inviteWithTwilio", withParameters: params as [NSObject : AnyObject], block: {
            (result: AnyObject?, error: NSError?) -> Void in
            if ( error == nil) {
                NSLog("success: \(result) ")
                return true
            }
            else if (error != nil) {
                NSLog("error: \(error!.userInfo)")
                return false
            }
            return false
        })
    }
    
    func verifyCode(){
        
    }
}