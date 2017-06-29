//
//  personalContact.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 18/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit

class personalContact: NSObject {
    
    var contactId: Int = Int()
    
    var FirstName: String = String()
    var LastName: String = String()
    var MI: String = String()
    var StreetAddress: String = String()
    var City: String = String()
    var State: String = String()
    var Zip: String = String()
    var Email: String = String()
    var PrimaryPhoneNumber: String = String()
    var SecondaryPhoneNumber: String = String()
    var SSN: String = String()
    var DriverLicense: String = String()
    var Relation : String = String()
   
    
    override init() {
        
    }
    
    init(contactId: Int,FirstName: String,LastName: String,MI: String,StreetAddress: String,City: String,State:String,Zip: String,Email: String,PrimaryPhoneNumber: String ,SecondaryPhoneNumber: String,SSN:String,DriverLicense: String,Relation: String)
     {
        
        self.contactId = contactId
        self.FirstName = FirstName
        self.LastName = LastName
        self.MI = MI
        self.StreetAddress = StreetAddress
        self.City = City
        self.State = State
        self.Zip = Zip
        self.Email = Email
        self.PrimaryPhoneNumber = PrimaryPhoneNumber
        self.SecondaryPhoneNumber = SecondaryPhoneNumber
        self.SSN = SSN
        self.DriverLicense = DriverLicense
        self.Relation = Relation
        
    }
    
    
}
