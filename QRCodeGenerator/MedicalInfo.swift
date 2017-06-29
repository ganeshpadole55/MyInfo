//
//  MedicalInfo.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 19/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit

class MedicalInfo: NSObject {

    var contactId: Int = Int() // ---> foreign key
    var MedicalInfoId: Int = Int()  //  same as foreign key
    var M_ID: Int = Int()   // primary key
    
    var PrimaryPhysicianName: String = String()
    var PrimaryPhysician: String = String()
    var PrimaryPhysicianAddress: String = String()
    
    var Disease: String =  String()
    
    override init() {
        
    }
    
    init(contactId: Int,MedicalInfoId: Int,M_ID: Int,PrimaryPhysicianName: String,PrimaryPhysician: String,PrimaryPhysicianAddress: String,Disease: String )
    {
    
        self.contactId = contactId
        self.MedicalInfoId = MedicalInfoId
        self.M_ID = M_ID
        self.PrimaryPhysicianName = PrimaryPhysicianName
        self.PrimaryPhysician = PrimaryPhysician
        self.PrimaryPhysicianAddress = PrimaryPhysicianAddress
        self.Disease = Disease
        
    }
    
}
