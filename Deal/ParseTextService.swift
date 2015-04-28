//
//  ParseTextService.swift
//  Deal
//
//  Created by Ki Suk Jang on 4/27/15.
//  Copyright (c) 2015 Ki Suk Jang. All rights reserved.
//

import Foundation

class ParseTextService {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    func getVerificationCode(my_num : String) -> Bool {
        let params = NSMutableDictionary()
        params.setObject(my_num, forKey: "number" )
        PFCloud.callFunctionInBackground("sendCode", withParameters: params as [NSObject : AnyObject], block: {
            (result: AnyObject?, error: NSError?) -> Void in
            if ( error == nil) {
                NSLog("success: \(result) ")
            }
            else if (error != nil) {
                NSLog("error: \(error!.userInfo)")
            }
        })
        return true
    }
    
    func verifyCode(my_num : String, code : String){
        let params = NSMutableDictionary()
        params.setObject(my_num, forKey: "number" )
        params.setObject(code, forKey: "code" )
        PFCloud.callFunctionInBackground("verifyCode", withParameters: params as [NSObject : AnyObject], block: {
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