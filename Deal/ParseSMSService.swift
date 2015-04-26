//
//  ParseSMSService.swift
//  Deal
//
//  Created by Ki Suk Jang on 4/25/15.
//  Copyright (c) 2015 Ki Suk Jang. All rights reserved.
//

import Foundation

class ParseSMSService {

    func getVerificationCode(my_num : String) -> Bool {
        PFCloud.callFunctionInBackground("inviteWithTwilio", withParameters: ["number" : my_num], block: nil)
        return true
    }
    
    func verifyCode(){
        
    }
}