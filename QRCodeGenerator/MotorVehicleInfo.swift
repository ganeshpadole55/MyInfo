//
//  MotorVehicleInfo.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 19/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit

class MotorVehicleInfo: NSObject {

    var contactId: Int = Int()  // ---> foreign key
    var MVehicleId: Int = Int() // same as foreign key
    var V_ID: Int = Int()  // primary key
    var Make: String = String()
    var Model: String = String()
    var VIN: String = String()
    var LicensePlate: String  = String()
   
    
    
    
    override init() {
        
    }
    
    init(contactId: Int,MVehicleId: Int,V_ID: Int,Make: String,Model: String,VIN: String,LicensePlate: String  )
    {
        
        self.contactId = contactId
        self.MVehicleId = MVehicleId
        self.V_ID = V_ID
        self.Make = Make
        self.Model = Model
        self.VIN = VIN
        self.LicensePlate = LicensePlate
       
        
    }

    
    
}
