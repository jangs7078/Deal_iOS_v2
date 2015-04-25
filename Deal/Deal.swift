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
        case ME_FILTER_TYPE
        case FAMILY_FILTER_TYPE
        case FRIENDS_FILTER_TYPE
    }
    
    var Deal_Id : String = ""
    var Dealer_Id : String = ""
    var Dealee_Id : String = ""
    var Task  : String = ""
    var Reward   : String = ""
    var Type   : FilterType = FilterType.ME_FILTER_TYPE
    var Complete : Bool = false
    
    init (task : String, reward :String, deal_type: FilterType, dealer_id : String, dealee_id : String) {
        self.Task = task
        self.Reward = reward
        self.Complete = false
        self.Type = deal_type
        
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
        case FilterType.ME_FILTER_TYPE :
            return 0
        case FilterType.FAMILY_FILTER_TYPE :
            return 1
        case FilterType.FRIENDS_FILTER_TYPE :
            return 2
        }
    }
    class func int_to_type (stored_type : Int) ->FilterType{
        switch (stored_type) {
        case 0:
            return FilterType.ME_FILTER_TYPE
        case 1 :
            return FilterType.FAMILY_FILTER_TYPE
        case 2:
            return FilterType.FRIENDS_FILTER_TYPE
        default :
            return  FilterType.ME_FILTER_TYPE
        }
    }
}