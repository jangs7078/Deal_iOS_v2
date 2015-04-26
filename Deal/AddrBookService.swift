//
//  AddrBookService.swift
//  Deal
//
//  Created by Ki Suk Jang on 4/23/15.
//  Copyright (c) 2015 Ki Suk Jang. All rights reserved.
//

import Foundation
import AddressBook

class AddrBookService {
    var addressBook: ABAddressBookRef?
    
    func requestAccess() {
        if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.NotDetermined) {
            var errorRef: Unmanaged<CFError>? = nil
            addressBook = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, &errorRef))
            ABAddressBookRequestAccessWithCompletion(addressBook, { success, error in
                if success {
                    self.getContactNames()
                }
                else {
                    println("error")
                }
            })
        }
        else if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Denied || ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Restricted) {
        }
        else if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Authorized) {
            self.getContactNames()
        }
    }
    
    func extractABAddressBookRef(abRef: Unmanaged<ABAddressBookRef>!) -> ABAddressBookRef? {
        if let ab = abRef {
            return Unmanaged<NSObject>.fromOpaque(ab.toOpaque()).takeUnretainedValue()
        }
        return nil
    }
    
    func getContactNames() {
        var errorRef: Unmanaged<CFError>?
        addressBook = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, &errorRef))
        var contactList: NSArray = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue()
        var list_of_num = [String]()
        for record:ABRecordRef in contactList {
            var contactPerson: ABRecordRef = record
            var contactRef: ABMultiValueRef = ABRecordCopyValue(contactPerson, AddressBook.kABPersonPhoneProperty).takeRetainedValue() as ABMultiValueRef
            var contactNum: String = ABMultiValueCopyValueAtIndex(contactRef, 0).takeRetainedValue() as! String
            println(contactNum)
            list_of_num.append(contactNum)
            //var contactName: String = ABRecordCopyCompositeName(contactPerson).takeRetainedValue() as String
        }
        
        ParseDBService().addFriends(list_of_num)
    }
}