//
//  Deal.swift
//  Deal
//
//  Created by Ki Suk Jang on 4/23/15.
//  Copyright (c) 2015 Ki Suk Jang. All rights reserved.
//

import Foundation

class Deal {
    
    enum FilterType {
        case PENDING
        case IN_PROGRESS
        case COMPLETE
    }
    
    var Deal_Id : String = ""
    var Dealer_Id : String = ""
    var Dealee_Id : String = ""
    var Task  : String = ""
    var Reward   : String = ""
    var State   : FilterType = FilterType.IN_PROGRESS
    
    init (task : String, reward :String, state_type: FilterType, dealer_id : String, dealee_id : String) {
        self.Task = task
        self.Reward = reward
        self.State = state_type
        
        self.Dealer_Id = dealer_id
        self.Dealee_Id = dealee_id
        self.Deal_Id = ""
        //super.init()
    }
    
    required init!(coder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getDealerId() -> String! {
        return self.Dealer_Id
    }
    
    func getDealeeId() -> String! {
        return self.Dealee_Id
    }
    
    class func type_to_int (type : FilterType) ->Int{
        switch (type) {
        case FilterType.PENDING :
            return 0
        case FilterType.IN_PROGRESS :
            return 1
        case FilterType.COMPLETE :
            return 2
        }
    }
    class func int_to_type (stored_type : Int) ->FilterType{
        switch (stored_type) {
        case 0:
            return FilterType.PENDING
        case 1 :
            return FilterType.IN_PROGRESS
        case 2:
            return FilterType.COMPLETE
        default :
            return  FilterType.PENDING
        }
    }
}