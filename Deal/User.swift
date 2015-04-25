//
//  User.swift
//  Deal
//
//  Created by Ki Suk Jang on 4/23/15.
//  Copyright (c) 2015 Ki Suk Jang. All rights reserved.
//

import Foundation

class User {
    
    var User_Id : String = ""
    var First_Name : String = ""
    var Last_Name : String = ""
    var Phone_Num  : String = ""
    var Profile_Photo : NSData? = nil
    
    init (id : String, first_name:String, last_name:String, photo: NSData) {
        self.User_Id = id
        self.First_Name = first_name
        self.Last_Name = last_name
        self.Profile_Photo = photo
    }
    
    required init!(coder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getFullName() -> String! {
        return self.First_Name + " " + self.Last_Name
    }
}