//
//  ModelManager.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 18/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//


/*
 database name :QRCODE.db
 
 tables:  contactInfo,medicalInfo, motorVehicleInfo
 
 
 1.      CREATE TABLE contactInfo(contactId integer primary key autoincrement not null,                          firstName text,lastName text,MI text,streetAddress text,city text,state text,zip text,email text,primaryPhone text,secondaryPhone text,SSN text,driverLicense text,relation text);
 
 
 2. CREATE TABLE medicalInfo(m_id integer primary key autoincrement,primaryPhysicianName text,primaryPhysician text,primaryPhysicianAddress text,disease text,medical_id integer,foreign key (medical_id) references contactInfo(contactId));
 
 3. CREATE TABLE motorVehicleInfo(v_id integer primary key autoincrement,m_vehicleId integer,make text,model text,vin text,licencePlate text,foreign key (m_vehicleId) references contactInfo(contactId));
 
 
 */

import UIKit
let sharedInstance = ModelManager()

import RNCryptor

class ModelManager: NSObject {
    
    
    
    var requestInfoFlag = false
    
    var myinfo_flag = false
    var create_flag = false // for create purpose
    var create_edit_flag = false // for edit purpose
    
    var edit_flag = false
    
    
    var medical_update_flag = false  // in edit tab after updating record in medical catagory
    var vehicle_update_flag = false  // in edit tab after updating record in vehicle catagory
    var insert_New_MedicalRecord_Flag = false // create new medical record from myinfo tab
    var insert_New_VehicleRecord_Flag = false // create new vehicle record from myinfo tab
    
    ///////////// password flag
    var login_flag = false
    var create_Password_flag = false
    var changePassword_flag = false
    
    
    //////////////
     var database: FMDatabase? = nil
     var sharedContactData:personalContact = personalContact()
     var Medical_ContactData:personalContact = personalContact()
    
    
     var myInfo_self_familyMemberFlag = false
    
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath("QRCODE.db"))
            
      
        }
        return sharedInstance
    }
    
    func deleteAllVehicleData() -> Bool {
        sharedInstance.database!.open()
        let deleted =  sharedInstance.database!.executeUpdate("delete  from motorVehicleInfo", withArgumentsIn: nil)
        
        return deleted
    }
    
    func deleteAllContactData() -> Bool {
        
        sharedInstance.database!.open()
        let deleted =  sharedInstance.database!.executeUpdate("delete  from contactInfo", withArgumentsIn: nil)
        
        return deleted
        
        
    }
    func deleteAllMedicalData() -> Bool{
        
            sharedInstance.database!.open()
            let deleted =  sharedInstance.database!.executeUpdate("delete  from medicalInfo", withArgumentsIn: nil)
            
            return deleted
            
           }
    
    
    func addPersonalContactData(_ personalInfo: personalContact) -> Bool {
        
       
        sharedInstance.database!.open()
        
      
        let password = "dalmet123"
        
        let firstName = personalInfo.FirstName
        let lastName = personalInfo.LastName
        let streetAddress = personalInfo.StreetAddress
        let city = personalInfo.City
        let state = personalInfo.State
        let zip = personalInfo.Zip
        let email = personalInfo.Email
        let relation = personalInfo.Relation
        
        let data_FirstName: NSData = firstName.data(using: .utf8)! as NSData
        let data_LastName: NSData = lastName.data(using: .utf8)! as NSData
        let data_streetAddress: NSData = streetAddress.data(using: .utf8)! as NSData
        let data_city: NSData = city.data(using: .utf8)! as NSData
        let data_state: NSData = state.data(using: .utf8)! as NSData
        let data_zip: NSData = zip.data(using: .utf8)! as NSData
        let data_email: NSData = email.data(using: .utf8)! as NSData
        
        
        let ciphertext_firstName = RNCryptor.encrypt(data: data_FirstName as Data, withPassword: password)
        let ciphertext_lastName = RNCryptor.encrypt(data: data_LastName as Data, withPassword: password)
        let ciphertext_streetAddress = RNCryptor.encrypt(data: data_streetAddress as Data, withPassword: password)
        let ciphertext_city = RNCryptor.encrypt(data: data_city as Data, withPassword: password)
        let ciphertext_state = RNCryptor.encrypt(data: data_state as Data, withPassword: password)
        let ciphertext_zip = RNCryptor.encrypt(data: data_zip as Data, withPassword: password)
        let ciphertext_email = RNCryptor.encrypt(data: data_email as Data, withPassword: password)
       
       
        
            let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO contactInfo (firstName, lastName,streetAddress,city,state,zip,email,relation) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [ciphertext_firstName, ciphertext_lastName, ciphertext_streetAddress, ciphertext_city,ciphertext_state,ciphertext_zip,ciphertext_email,relation])
        
        
            let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("select last_insert_rowid()", withArgumentsIn: nil)
       
            if (resultSet != nil) {
                while resultSet.next()
                {
                    
                    // to get last inserted record id
                    
                    personalInfo.contactId = Int(resultSet.int(forColumnIndex: 0))
                    
                    sharedContactData = personalInfo
                    
                    print(resultSet.int(forColumnIndex: 0));

                }
        }

        sharedInstance.database!.close()
            return isInserted
        
    
        
        
    }
    
    // update person data--> Contact
    func updatePersonData(_ personContactData: personalContact) -> Bool {
        sharedInstance.database!.open()
        /*
         1.      CREATE TABLE contactInfo(contactId integer primary key autoincrement not null,                          firstName text,lastName text,MI text,streetAddress text,city text,state text,zip text,email text,primaryPhone text,secondaryPhone text,SSN text,driverLicense text,relation text);
         
         */
        
        
        let password = "dalmet123"
        
        let firstName = personContactData.FirstName
        let lastName = personContactData.LastName
        let streetAddress = personContactData.StreetAddress
        let city = personContactData.City
        let state = personContactData.State
        let zip = personContactData.Zip
        let email = personContactData.Email
        let mi = personContactData.MI
        let primaryPhone = personContactData.PrimaryPhoneNumber
        let secondaryPhone = personContactData.SecondaryPhoneNumber
        let ssn = personContactData.SSN
        let driverLicense = personContactData.DriverLicense
        let relation = personContactData.Relation
        
        
        
        
        let data_FirstName: NSData = firstName.data(using: .utf8)! as NSData
        let data_LastName: NSData = lastName.data(using: .utf8)! as NSData
        let data_streetAddress: NSData = streetAddress.data(using: .utf8)! as NSData
        let data_city: NSData = city.data(using: .utf8)! as NSData
        let data_state: NSData = state.data(using: .utf8)! as NSData
        let data_zip: NSData = zip.data(using: .utf8)! as NSData
        let data_email: NSData = email.data(using: .utf8)! as NSData
        let data_mi: NSData = mi.data(using: .utf8)! as NSData
        let data_primaryPhone: NSData = primaryPhone.data(using: .utf8)! as NSData
        let data_secondaryPhone: NSData = secondaryPhone.data(using: .utf8)! as NSData
        let data_ssn: NSData = ssn.data(using: .utf8)! as NSData
        let data_driverLicense: NSData = driverLicense.data(using: .utf8)! as NSData
       
        
        
        let ciphertext_firstName = RNCryptor.encrypt(data: data_FirstName as Data, withPassword: password)
        let ciphertext_lastName = RNCryptor.encrypt(data: data_LastName as Data, withPassword: password)
        let ciphertext_streetAddress = RNCryptor.encrypt(data: data_streetAddress as Data, withPassword: password)
        let ciphertext_city = RNCryptor.encrypt(data: data_city as Data, withPassword: password)
        let ciphertext_state = RNCryptor.encrypt(data: data_state as Data, withPassword: password)
        let ciphertext_zip = RNCryptor.encrypt(data: data_zip as Data, withPassword: password)
        let ciphertext_email = RNCryptor.encrypt(data: data_email as Data, withPassword: password)
        let ciphertext_mi = RNCryptor.encrypt(data: data_mi as Data, withPassword: password)
        let ciphertext_primaryPhone = RNCryptor.encrypt(data: data_primaryPhone as Data, withPassword: password)
        let ciphertext_secondaryPhone = RNCryptor.encrypt(data: data_secondaryPhone as Data, withPassword: password)
        let ciphertext_ssn = RNCryptor.encrypt(data: data_ssn as Data, withPassword: password)
        let ciphertext_driverLicense = RNCryptor.encrypt(data: data_driverLicense as Data, withPassword: password)
        
      
        
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE contactInfo SET firstName=?, lastName=?, MI=?, streetAddress=?, city=?, state=?, zip=?, email=?, primaryPhone=?, secondaryPhone=?, SSN=?, driverLicense=?, relation=?  WHERE contactId=?", withArgumentsIn: [ciphertext_firstName, ciphertext_lastName, ciphertext_mi,ciphertext_streetAddress,ciphertext_city,ciphertext_state,ciphertext_zip,ciphertext_email,ciphertext_primaryPhone,ciphertext_secondaryPhone,ciphertext_ssn,ciphertext_driverLicense,relation,personContactData.contactId])
        
         sharedContactData = personContactData
        
        sharedInstance.database!.close()
        return isUpdated
    }
    
    
    // delete person info by passing id
    
    func deletePersonDataById(_ personInfo: personalContact) -> Bool {
        sharedInstance.database!.open()
        
        // for contact 
        
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM contactInfo WHERE contactId=?", withArgumentsIn: [personInfo.contactId])
        
         print("Is person data deleted :", isDeleted)
        // for vehicle
        
        let deleteMotorVehicle =  sharedInstance.database!.executeUpdate("DELETE FROM motorVehicleInfo WHERE m_vehicleId=?", withArgumentsIn: [personInfo.contactId])
        
        print("Is motor vehicle data deleted :", deleteMotorVehicle)
        
        // for medical
        
        let deleteMedicleInfo = sharedInstance.database!.executeUpdate("DELETE FROM medicalInfo WHERE medical_id=?", withArgumentsIn: [personInfo.contactId])
        
         print("Is medicle data deleted :", deleteMedicleInfo)
        
        
        // for employment
        
        
        sharedInstance.database!.close()
        return isDeleted
    }
    
    // create table motorVehicleInfo(m_id integer primary key autoincrement,m_vehicleId integer,make text,model text,vin text,licencePlate text,foreign key (m_vehicleId) references contactInfo(contactId));
    
    func getMyMotorVehicleData(id: Int) -> NSMutableArray {
         sharedInstance.database!.open()
        
        let resultSet: FMResultSet  = sharedInstance.database!.executeQuery("select * from motorVehicleInfo where m_vehicleId=?", withArgumentsIn: [id])
        
        let vehicleInfo: NSMutableArray = NSMutableArray()
        
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                let motorVehicleObject:MotorVehicleInfo = MotorVehicleInfo()
                motorVehicleObject.MVehicleId = Int(resultSet.int(forColumn: "m_vehicleId"))
                motorVehicleObject.V_ID = Int(resultSet.int(forColumn: "v_id"))
                
            
                
                // decrypt data
                let password = "dalmet123"
                
                do {
                    
                    if let make =  resultSet.data(forColumn: "make"){
                        
                        let originalData_make = try RNCryptor.decrypt(data: make, withPassword: password)
                        let Make = NSString(data: originalData_make, encoding: String.Encoding.utf8.rawValue)
                        
                        motorVehicleObject.Make = Make! as String
                    }
                    if let model = resultSet.data(forColumn: "model"){
                        
                        let originalData_model = try RNCryptor.decrypt(data: model, withPassword: password)
                        let Model = NSString(data: originalData_model, encoding: String.Encoding.utf8.rawValue)
                        
                        motorVehicleObject.Model = Model! as String
                    }
                    if let vin = resultSet.data(forColumn: "vin"){
                        
                        let originalData_vin = try RNCryptor.decrypt(data: vin, withPassword: password)
                        let Vin = NSString(data: originalData_vin, encoding: String.Encoding.utf8.rawValue)
                        
                        motorVehicleObject.VIN = Vin! as String
                    }
                    
                    if let licensePlate = resultSet.data(forColumn: "licencePlate"){
                        
                        let originalData_licensePlate = try RNCryptor.decrypt(data: licensePlate, withPassword: password)
                        let LicensePlate = NSString(data: originalData_licensePlate, encoding: String.Encoding.utf8.rawValue)
                        
                        motorVehicleObject.LicensePlate = LicensePlate! as String
                    }
                    
                    
                } catch  {
                    print(error)
                }

                
                
                vehicleInfo.add(motorVehicleObject)
            }
        }
        sharedInstance.database!.close()
        return vehicleInfo
        
        
    }
    
    
    func getMyMedicalData(id: Int) -> NSMutableArray {
        
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet  = sharedInstance.database!.executeQuery("select * from medicalInfo where medical_id=?", withArgumentsIn: [id])
        
        let medicalInfo: NSMutableArray = NSMutableArray()
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                let medicalInfoObject: MedicalInfo = MedicalInfo()
                medicalInfoObject.MedicalInfoId = Int(resultSet.int(forColumn: "medical_id"))
                medicalInfoObject.contactId = Int(resultSet.int(forColumn: "medical_id"))
                medicalInfoObject.M_ID = Int(resultSet.int(forColumn: "m_id"))
                
                // decrypt data
                let password = "dalmet123"
                do {
                   
                    if let PrimaryPhysicianName = resultSet.data(forColumn: "primaryPhysicianName"){
                        
                        let originalData_PrimaryPhysicianName = try RNCryptor.decrypt(data: PrimaryPhysicianName, withPassword: password)
                        let primaryPhysicianName = NSString(data: originalData_PrimaryPhysicianName, encoding: String.Encoding.utf8.rawValue)
                        
                        medicalInfoObject.PrimaryPhysicianName = primaryPhysicianName! as String
                    }
                    if let PrimaryPhysician = resultSet.data(forColumn: "primaryPhysician"){
                        
                        let originalData_PrimaryPhysician = try RNCryptor.decrypt(data: PrimaryPhysician, withPassword: password)
                        let primaryPhysician = NSString(data: originalData_PrimaryPhysician, encoding: String.Encoding.utf8.rawValue)
                        
                        medicalInfoObject.PrimaryPhysician = primaryPhysician! as String
                    }
                    if let address = resultSet.data(forColumn: "primaryPhysicianAddress"){
                        
                        let originalData_address = try RNCryptor.decrypt(data: address, withPassword: password)
                        let Address = NSString(data: originalData_address, encoding: String.Encoding.utf8.rawValue)
                        
                        
                        medicalInfoObject.PrimaryPhysicianAddress = Address! as String
                    }
                    if let disease = resultSet.data(forColumn: "disease"){
                      
                        let originalData_disease = try RNCryptor.decrypt(data: disease, withPassword: password)
                        let Disease = NSString(data: originalData_disease, encoding: String.Encoding.utf8.rawValue)
                        
                        
                        medicalInfoObject.Disease = Disease! as String
                    }
                    
                } catch{
                    print(error)
                }
                
                 
               
                medicalInfo.add(medicalInfoObject)
            }
        }
        sharedInstance.database!.close()
        return medicalInfo
        
    }
    
    
    func getMyOwnData(name: String) -> NSMutableArray {
        
        sharedInstance.database!.open()
        
        let password = "dalmet123"
        
        
        let resultSet: FMResultSet = sharedInstance.database!.executeQuery("select * from contactInfo where relation=?", withArgumentsIn: [name])
        let contactInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                
                let personalInfo : personalContact = personalContact()
               
                
                personalInfo.contactId = Int(resultSet.int(forColumn: "contactId"))
                // Decryption
                do {
                    
                    if let first_Name = resultSet.data(forColumn: "firstName"){
                        
                        let originalData_FirstName = try RNCryptor.decrypt(data: first_Name, withPassword: password)
                        let firstName = NSString(data: originalData_FirstName, encoding: String.Encoding.utf8.rawValue)
                        personalInfo.FirstName = firstName! as String
                    }
                    
                    if let last_Name = resultSet.data(forColumn: "lastName"){
                        
                        let originalData_last_Name = try RNCryptor.decrypt(data: last_Name, withPassword: password)
                        let lastName = NSString(data: originalData_last_Name, encoding: String.Encoding.utf8.rawValue)
                        personalInfo.LastName = lastName! as String
                        
                        
                    }
                    if let MI = resultSet.data(forColumn: "MI"){
                        
                        let originalData_MI = try RNCryptor.decrypt(data: MI, withPassword: password)
                        let MIName = NSString(data: originalData_MI, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.MI = MIName! as String
                    }
                    
                    if let StreetAddress = resultSet.data(forColumn: "streetAddress"){
                        let originalData_StreetAddress = try RNCryptor.decrypt(data: StreetAddress, withPassword: password)
                        let address = NSString(data: originalData_StreetAddress, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.StreetAddress = address! as String
                    }
                    
                    if let City = resultSet.data(forColumn: "city"){
                        let originalData_City = try RNCryptor.decrypt(data: City, withPassword: password)
                        let city = NSString(data: originalData_City, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.City = city! as String
                    }
                    
                    if let State = resultSet.data(forColumn: "state"){
                        
                        let originalData_State = try RNCryptor.decrypt(data: State, withPassword: password)
                        let state = NSString(data: originalData_State, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.State = state! as String
                    }
                    
                    if let Zip = resultSet.data(forColumn: "zip"){
                        
                        let originalData_Zip = try RNCryptor.decrypt(data: Zip, withPassword: password)
                        let zip = NSString(data: originalData_Zip, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.Zip = zip! as String
                        
                    }
                    if let Email = resultSet.data(forColumn: "email"){
                        let originalData_Email = try RNCryptor.decrypt(data: Email, withPassword: password)
                        let email = NSString(data: originalData_Email, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.Email = email! as String
                    }
                    
                    if let PrimaryPhone = resultSet.data(forColumn: "primaryPhone"){
                        let originalData_PrimaryPhone = try RNCryptor.decrypt(data: PrimaryPhone, withPassword: password)
                        let primaryPhone = NSString(data: originalData_PrimaryPhone, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.PrimaryPhoneNumber = primaryPhone! as String
                    }
                    
                    if let SecondaryPhone = resultSet.data(forColumn: "secondaryPhone"){
                        let originalData_SecondaryPhone = try RNCryptor.decrypt(data: SecondaryPhone, withPassword: password)
                        let secondaryPhone = NSString(data: originalData_SecondaryPhone, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.SecondaryPhoneNumber = secondaryPhone! as String
                    }
                    
                    if let SSN = resultSet.data(forColumn: "SSN"){
                        let originalData_SSN = try RNCryptor.decrypt(data: SSN, withPassword: password)
                        let ssn = NSString(data: originalData_SSN, encoding: String.Encoding.utf8.rawValue)
                        personalInfo.SSN = ssn! as String
                    }
                    if let DriverLicense = resultSet.data(forColumn: "driverLicense"){
                        let originalData_DriverLicense = try RNCryptor.decrypt(data: DriverLicense, withPassword: password)
                        let driverLicense = NSString(data: originalData_DriverLicense, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.DriverLicense = driverLicense! as String
                    }
                    if let Relation = resultSet.string(forColumn: "relation"){
                        
                        personalInfo.Relation = Relation as String
                    }
                    
                    
                } catch {
                    print(error)
                }
                
                
                contactInfo.add(personalInfo)
            }
        }
        sharedInstance.database!.close()
        return contactInfo
        
    }
    
    
    
    func getPersonName_RelationInfoData() -> NSMutableArray {
        
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM contactInfo", withArgumentsIn: nil)
        let contactInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                
                let personalInfo : personalContact = personalContact()
                
                let password = "dalmet123"
                
                personalInfo.contactId = Int(resultSet.int(forColumn: "contactId"))
                
                
                // Decryption
                do {
                    
                    if let first_Name = resultSet.data(forColumn: "firstName"){
                        
                        let originalData_FirstName = try RNCryptor.decrypt(data: first_Name, withPassword: password)
                        let firstName = NSString(data: originalData_FirstName, encoding: String.Encoding.utf8.rawValue)
                        personalInfo.FirstName = firstName! as String
                    }
                    
                    if let Relation = resultSet.string(forColumn: "relation"){
                        
                        personalInfo.Relation = Relation as String
                    }
                    
                    
                } catch {
                    print(error)
                }
                
                contactInfo.add(personalInfo)
            }
        }
        sharedInstance.database!.close()
        return contactInfo
        
    }
    
    
  func  getAllContactInfoData() -> NSMutableArray
  {
    
    sharedInstance.database!.open()
    
    let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM contactInfo", withArgumentsIn: nil)
    let contactInfo : NSMutableArray = NSMutableArray()
    if (resultSet != nil) {
        while resultSet.next() {
            
            let personalInfo : personalContact = personalContact()
            
            let password = "dalmet123"
            
            personalInfo.contactId = Int(resultSet.int(forColumn: "contactId"))
            
            
            // Decryption
            do {
                
                if let first_Name = resultSet.data(forColumn: "firstName"){
                  
                let originalData_FirstName = try RNCryptor.decrypt(data: first_Name, withPassword: password)
                let firstName = NSString(data: originalData_FirstName, encoding: String.Encoding.utf8.rawValue)
                personalInfo.FirstName = firstName! as String
                }
                
                if let last_Name = resultSet.data(forColumn: "lastName"){
                    
                    let originalData_last_Name = try RNCryptor.decrypt(data: last_Name, withPassword: password)
                    let lastName = NSString(data: originalData_last_Name, encoding: String.Encoding.utf8.rawValue)
                    personalInfo.LastName = lastName! as String
                    
                    
                }
                if let MI = resultSet.data(forColumn: "MI"){
                    
                    let originalData_MI = try RNCryptor.decrypt(data: MI, withPassword: password)
                    let MIName = NSString(data: originalData_MI, encoding: String.Encoding.utf8.rawValue)
                    
                    personalInfo.MI = MIName! as String
                }
                
                if let StreetAddress = resultSet.data(forColumn: "streetAddress"){
                    let originalData_StreetAddress = try RNCryptor.decrypt(data: StreetAddress, withPassword: password)
                    let address = NSString(data: originalData_StreetAddress, encoding: String.Encoding.utf8.rawValue)
                 
                    personalInfo.StreetAddress = address! as String
                }
                
                if let City = resultSet.data(forColumn: "city"){
                    let originalData_City = try RNCryptor.decrypt(data: City, withPassword: password)
                    let city = NSString(data: originalData_City, encoding: String.Encoding.utf8.rawValue)
                    
                    personalInfo.City = city! as String
                }
                
                if let State = resultSet.data(forColumn: "state"){
                    
                    let originalData_State = try RNCryptor.decrypt(data: State, withPassword: password)
                    let state = NSString(data: originalData_State, encoding: String.Encoding.utf8.rawValue)
                    
                    personalInfo.State = state! as String
                }
                
                if let Zip = resultSet.data(forColumn: "zip"){
                    
                    let originalData_Zip = try RNCryptor.decrypt(data: Zip, withPassword: password)
                    let zip = NSString(data: originalData_Zip, encoding: String.Encoding.utf8.rawValue)
                    
                    personalInfo.Zip = zip! as String
                
                }
                if let Email = resultSet.data(forColumn: "email"){
                    let originalData_Email = try RNCryptor.decrypt(data: Email, withPassword: password)
                    let email = NSString(data: originalData_Email, encoding: String.Encoding.utf8.rawValue)
                    
                    personalInfo.Email = email! as String
                }
                
                if let PrimaryPhone = resultSet.data(forColumn: "primaryPhone"){
                    let originalData_PrimaryPhone = try RNCryptor.decrypt(data: PrimaryPhone, withPassword: password)
                    let primaryPhone = NSString(data: originalData_PrimaryPhone, encoding: String.Encoding.utf8.rawValue)
                    
                    personalInfo.PrimaryPhoneNumber = primaryPhone! as String
                }
                
                if let SecondaryPhone = resultSet.data(forColumn: "secondaryPhone"){
                    let originalData_SecondaryPhone = try RNCryptor.decrypt(data: SecondaryPhone, withPassword: password)
                    let secondaryPhone = NSString(data: originalData_SecondaryPhone, encoding: String.Encoding.utf8.rawValue)
                    
                    personalInfo.SecondaryPhoneNumber = secondaryPhone! as String
                }
                
                if let SSN = resultSet.data(forColumn: "SSN"){
                    let originalData_SSN = try RNCryptor.decrypt(data: SSN, withPassword: password)
                    let ssn = NSString(data: originalData_SSN, encoding: String.Encoding.utf8.rawValue)
                    personalInfo.SSN = ssn! as String
                }
                if let DriverLicense = resultSet.data(forColumn: "driverLicense"){
                    let originalData_DriverLicense = try RNCryptor.decrypt(data: DriverLicense, withPassword: password)
                    let driverLicense = NSString(data: originalData_DriverLicense, encoding: String.Encoding.utf8.rawValue)
                    
                    personalInfo.DriverLicense = driverLicense! as String
                }
                if let Relation = resultSet.string(forColumn: "relation"){
                    
                    personalInfo.Relation = Relation as String
                }

                
               } catch {
                       print(error)
            }
            
            contactInfo.add(personalInfo)
        }
    }
    sharedInstance.database!.close()
    return contactInfo
}
    
    
    func getAllSelectedContactInfoData(contactIdValue: Int) -> NSMutableArray {
        
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM contactInfo where contactId=?", withArgumentsIn: [contactIdValue])
        let contactInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                
                let personalInfo : personalContact = personalContact()
                let password = "dalmet123"
                
                personalInfo.contactId = Int(resultSet.int(forColumn: "contactId"))
                // Decryption
                do {
                    
                    if let first_Name = resultSet.data(forColumn: "firstName"){
                        
                        let originalData_FirstName = try RNCryptor.decrypt(data: first_Name, withPassword: password)
                        let firstName = NSString(data: originalData_FirstName, encoding: String.Encoding.utf8.rawValue)
                        personalInfo.FirstName = firstName! as String
                    }
                    
                    if let last_Name = resultSet.data(forColumn: "lastName"){
                        
                        let originalData_last_Name = try RNCryptor.decrypt(data: last_Name, withPassword: password)
                        let lastName = NSString(data: originalData_last_Name, encoding: String.Encoding.utf8.rawValue)
                        personalInfo.LastName = lastName! as String
                        
                        
                    }
                    if let MI = resultSet.data(forColumn: "MI"){
                        
                        let originalData_MI = try RNCryptor.decrypt(data: MI, withPassword: password)
                        let MIName = NSString(data: originalData_MI, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.MI = MIName! as String
                    }
                    
                    if let StreetAddress = resultSet.data(forColumn: "streetAddress"){
                        let originalData_StreetAddress = try RNCryptor.decrypt(data: StreetAddress, withPassword: password)
                        let address = NSString(data: originalData_StreetAddress, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.StreetAddress = address! as String
                    }
                    
                    if let City = resultSet.data(forColumn: "city"){
                        let originalData_City = try RNCryptor.decrypt(data: City, withPassword: password)
                        let city = NSString(data: originalData_City, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.City = city! as String
                    }
                    
                    if let State = resultSet.data(forColumn: "state"){
                        
                        let originalData_State = try RNCryptor.decrypt(data: State, withPassword: password)
                        let state = NSString(data: originalData_State, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.State = state! as String
                    }
                    
                    if let Zip = resultSet.data(forColumn: "zip"){
                        
                        let originalData_Zip = try RNCryptor.decrypt(data: Zip, withPassword: password)
                        let zip = NSString(data: originalData_Zip, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.Zip = zip! as String
                        
                    }
                    if let Email = resultSet.data(forColumn: "email"){
                        let originalData_Email = try RNCryptor.decrypt(data: Email, withPassword: password)
                        let email = NSString(data: originalData_Email, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.Email = email! as String
                    }
                    
                    if let PrimaryPhone = resultSet.data(forColumn: "primaryPhone"){
                        let originalData_PrimaryPhone = try RNCryptor.decrypt(data: PrimaryPhone, withPassword: password)
                        let primaryPhone = NSString(data: originalData_PrimaryPhone, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.PrimaryPhoneNumber = primaryPhone! as String
                    }
                    
                    if let SecondaryPhone = resultSet.data(forColumn: "secondaryPhone"){
                        let originalData_SecondaryPhone = try RNCryptor.decrypt(data: SecondaryPhone, withPassword: password)
                        let secondaryPhone = NSString(data: originalData_SecondaryPhone, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.SecondaryPhoneNumber = secondaryPhone! as String
                    }
                    
                    if let SSN = resultSet.data(forColumn: "SSN"){
                        let originalData_SSN = try RNCryptor.decrypt(data: SSN, withPassword: password)
                        let ssn = NSString(data: originalData_SSN, encoding: String.Encoding.utf8.rawValue)
                        personalInfo.SSN = ssn! as String
                    }
                    if let DriverLicense = resultSet.data(forColumn: "driverLicense"){
                        let originalData_DriverLicense = try RNCryptor.decrypt(data: DriverLicense, withPassword: password)
                        let driverLicense = NSString(data: originalData_DriverLicense, encoding: String.Encoding.utf8.rawValue)
                        
                        personalInfo.DriverLicense = driverLicense! as String
                    }
                    if let Relation = resultSet.string(forColumn: "relation"){
                       
                        
                        personalInfo.Relation = Relation as String
                    }
                    
                    
                } catch {
                    print(error)
                }
     
                contactInfo.add(personalInfo)
            }
        }
        sharedInstance.database!.close()
        return contactInfo
    }
    
    
    // Medical Information
    
    /*
     create table medicalInfo(  m_id integer primary key autoincrement, 
                                primaryPhysicianName text,
                                primaryPhysician text,
                                primaryPhysicianAddress text,
                                disease text,medical_id integer,
                                foreign key (medical_id) references contactInfo(contactId));
     */
    
    // Add person medical data
    
    func addPersonMedicalData(_ personMedicalInfo: MedicalInfo) -> Bool {
        
        
        sharedInstance.database!.open()
        
        let password = "dalmet123"
        
        let primaryPhysicianName = personMedicalInfo.PrimaryPhysicianName
        let primaryPhysician = personMedicalInfo.PrimaryPhysician
        let primaryPhysicianAddress = personMedicalInfo.PrimaryPhysicianAddress
        let disease = personMedicalInfo.Disease
        
        
        
        let data_primaryPhysicianName: NSData = primaryPhysicianName.data(using: .utf8)! as NSData
        let data_primaryPhysician: NSData = primaryPhysician.data(using: .utf8)! as NSData
        let data_primaryPhysicianAddress: NSData = primaryPhysicianAddress.data(using: .utf8)! as NSData
        let data_disease: NSData = disease.data(using: .utf8)! as NSData
        
        
        let ciphertext_primaryPhysicianName = RNCryptor.encrypt(data: data_primaryPhysicianName as Data, withPassword: password)
        let ciphertext_primaryPhysician = RNCryptor.encrypt(data: data_primaryPhysician as Data, withPassword: password)
        let ciphertext_primaryPhysicianAddress = RNCryptor.encrypt(data: data_primaryPhysicianAddress as Data, withPassword: password)
        let ciphertext_disease = RNCryptor.encrypt(data: data_disease as Data, withPassword: password)
        
        
        
        
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO medicalInfo(medical_id,primaryPhysicianName,primaryPhysician,primaryPhysicianAddress,disease) values (?, ?, ?, ?, ?)", withArgumentsIn: [personMedicalInfo.MedicalInfoId, ciphertext_primaryPhysicianName, ciphertext_primaryPhysician, ciphertext_primaryPhysicianAddress, ciphertext_disease])
        
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("select last_insert_rowid()", withArgumentsIn: nil)
        
        if (resultSet != nil) {
            while resultSet.next()
            {
                
                // to get last inserted record id
                
                personMedicalInfo.M_ID = Int(resultSet.int(forColumnIndex: 0))
                
                print("M_Id:", resultSet.int(forColumnIndex: 0));
                
            }
        }

        
        sharedInstance.database!.close()
        return isInserted
    
    }

    // Update Person Medical Data
    func updatePersonMedicalData(_ personMedicalInfo: MedicalInfo) -> Bool {
        
        
        sharedInstance.database!.open()
        
        let password = "dalmet123"
        
        let primaryPhysicianName = personMedicalInfo.PrimaryPhysicianName
        let primaryPhysician = personMedicalInfo.PrimaryPhysician
        let primaryPhysicianAddress = personMedicalInfo.PrimaryPhysicianAddress
        let disease = personMedicalInfo.Disease
        
        
        
        let data_primaryPhysicianName: NSData = primaryPhysicianName.data(using: .utf8)! as NSData
        let data_primaryPhysician: NSData = primaryPhysician.data(using: .utf8)! as NSData
        let data_primaryPhysicianAddress: NSData = primaryPhysicianAddress.data(using: .utf8)! as NSData
        let data_disease: NSData = disease.data(using: .utf8)! as NSData
        
        
        let ciphertext_primaryPhysicianName = RNCryptor.encrypt(data: data_primaryPhysicianName as Data, withPassword: password)
        let ciphertext_primaryPhysician = RNCryptor.encrypt(data: data_primaryPhysician as Data, withPassword: password)
        let ciphertext_primaryPhysicianAddress = RNCryptor.encrypt(data: data_primaryPhysicianAddress as Data, withPassword: password)
        let ciphertext_disease = RNCryptor.encrypt(data: data_disease as Data, withPassword: password)
        
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE medicalInfo SET primaryPhysicianName=?, primaryPhysician=?, primaryPhysicianAddress=?, disease=? WHERE medical_id=? AND m_id=?", withArgumentsIn: [ciphertext_primaryPhysicianName, ciphertext_primaryPhysician, ciphertext_primaryPhysicianAddress, ciphertext_disease, personMedicalInfo.MedicalInfoId, personMedicalInfo.M_ID])
        
          sharedInstance.database!.close()
        
        return isUpdated
    }
    
    
    func getSelectedIdMedicalInfo(contactIdValue: Int) -> NSMutableArray {
        
        
        sharedInstance.database!.open()
        let medicalInfo : NSMutableArray = NSMutableArray()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM medicalInfo where medical_id=?", withArgumentsIn: [contactIdValue])
        
        if(resultSet != nil)
        {
            while resultSet.next()
            {
                let medicalInfoObject: MedicalInfo = MedicalInfo()
                medicalInfoObject.MedicalInfoId = Int(resultSet.int(forColumn: "medical_id"))
                medicalInfoObject.M_ID = Int(resultSet.int(forColumn: "m_id"))
             
                // decrypt data
                let password = "dalmet123"
                
                do {
                   
                    if let primaryPhysicianName = resultSet.data(forColumn: "primaryPhysicianName"){
                        
                        let originalData_primaryPhysicianName = try RNCryptor.decrypt(data: primaryPhysicianName, withPassword: password)
                        let primaryphysicianname = NSString(data: originalData_primaryPhysicianName, encoding: String.Encoding.utf8.rawValue)
                       medicalInfoObject.PrimaryPhysicianName = primaryphysicianname! as String
                    }
                    
                    if let PrimaryPhysician = resultSet.data(forColumn: "primaryPhysician"){
                        
                    let originalData_PrimaryPhysician = try RNCryptor.decrypt(data: PrimaryPhysician, withPassword: password)
                        let primaryPhysician = NSString(data: originalData_PrimaryPhysician, encoding: String.Encoding.utf8.rawValue)
                        
                        
                        medicalInfoObject.PrimaryPhysician = primaryPhysician! as String
                    }
                    
                    if let address = resultSet.data(forColumn: "primaryPhysicianAddress"){
                        
                        let originalData_address = try RNCryptor.decrypt(data: address, withPassword: password)
                        let Address = NSString(data: originalData_address, encoding: String.Encoding.utf8.rawValue)
                        
                        
                        medicalInfoObject.PrimaryPhysicianAddress = Address! as String
                    }
                    
                    if let disease = resultSet.data(forColumn: "disease"){
                        
                        let originalData_disease = try RNCryptor.decrypt(data: disease, withPassword: password)
                        let Disease = NSString(data: originalData_disease, encoding: String.Encoding.utf8.rawValue)
                        
                        
                        medicalInfoObject.Disease = Disease! as String
                        
                    }
                    
                    medicalInfo.add(medicalInfoObject)
                    
                } catch {
                    print(error)
                }
                
               
                
            }
            
        }
        
        sharedInstance.database!.close()
        return medicalInfo
    }
    
    
    func getAllMedicalInfoData() -> NSMutableArray {
        
        sharedInstance.database!.open()
        let medicalInfo : NSMutableArray = NSMutableArray()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM medicalInfo", withArgumentsIn: nil)
        
        if(resultSet != nil)
        {
            while resultSet.next()
            {
                let medicalInfoObject: MedicalInfo = MedicalInfo()
                medicalInfoObject.MedicalInfoId = Int(resultSet.int(forColumn: "medical_id"))  // foreign key
                medicalInfoObject.M_ID = Int(resultSet.int(forColumn: "m_id"))  // primary key
                
                // decrypt data
                let password = "dalmet123"
                
                do {
                    
                    if let primaryPhysicianName = resultSet.data(forColumn: "primaryPhysicianName"){
                        
                        let originalData_primaryPhysicianName = try RNCryptor.decrypt(data: primaryPhysicianName, withPassword: password)
                        let primaryphysicianname = NSString(data: originalData_primaryPhysicianName, encoding: String.Encoding.utf8.rawValue)
                        medicalInfoObject.PrimaryPhysicianName = primaryphysicianname! as String
                    }
                    
                    if let PrimaryPhysician = resultSet.data(forColumn: "primaryPhysician"){
                        
                        let originalData_PrimaryPhysician = try RNCryptor.decrypt(data: PrimaryPhysician, withPassword: password)
                        let primaryPhysician = NSString(data: originalData_PrimaryPhysician, encoding: String.Encoding.utf8.rawValue)
                        
                        
                        medicalInfoObject.PrimaryPhysician = primaryPhysician! as String
                    }
                    
                    if let address = resultSet.data(forColumn: "primaryPhysicianAddress"){
                        
                        let originalData_address = try RNCryptor.decrypt(data: address, withPassword: password)
                        let Address = NSString(data: originalData_address, encoding: String.Encoding.utf8.rawValue)
                        
                        
                        medicalInfoObject.PrimaryPhysicianAddress = Address! as String
                    }
                    
                    if let disease = resultSet.data(forColumn: "disease"){
                        
                        let originalData_disease = try RNCryptor.decrypt(data: disease, withPassword: password)
                        let Disease = NSString(data: originalData_disease, encoding: String.Encoding.utf8.rawValue)
                        
                        
                        medicalInfoObject.Disease = Disease! as String
                        
                    }
                    
                    medicalInfo.add(medicalInfoObject)
                    
                } catch {
                    print(error)
                }
                
            }
            
        }
        
        sharedInstance.database!.close()
        return medicalInfo
    }
    //deletePersonMedicalDataById

    // delete person info by passing id
    
    func deletePersonMedicalDataById(_ medicalInfo: MedicalInfo) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM medicalInfo WHERE medical_id=? AND m_id=?", withArgumentsIn: [medicalInfo.MedicalInfoId, medicalInfo.M_ID])
        sharedInstance.database!.close()
        return isDeleted
    }
    
    
    // Motor Vehicle Information
    
    // create table motorVehicleInfo(v_id integer primary key autoincrement,m_vehicleId integer,make text,model text,vin text,licencePlate text,foreign key (m_vehicleId) references contactInfo(contactId));
    
    
    func addMotorVehicleInfo(_ VehicleInfo: MotorVehicleInfo) -> Bool { // Insert Motor Vehicle Info
        
        
        sharedInstance.database!.open()
        
        print(VehicleInfo.MVehicleId)
        
        // encrypt data
        
        let password = "dalmet123"
        
        let make = VehicleInfo.Make
        let model = VehicleInfo.Model
        let vin = VehicleInfo.VIN
        let licensePlate = VehicleInfo.LicensePlate
        
        
        
        let data_make: NSData = make.data(using: .utf8)! as NSData
        let data_model: NSData = model.data(using: .utf8)! as NSData
        let data_vin: NSData = vin.data(using: .utf8)! as NSData
        let data_licensePlate: NSData = licensePlate.data(using: .utf8)! as NSData
        
        
        let ciphertext_make = RNCryptor.encrypt(data: data_make as Data, withPassword: password)
        let ciphertext_model = RNCryptor.encrypt(data: data_model as Data, withPassword: password)
        let ciphertext_vin = RNCryptor.encrypt(data: data_vin as Data, withPassword: password)
        let ciphertext_licensePlate = RNCryptor.encrypt(data: data_licensePlate as Data, withPassword: password)
        
        
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO motorVehicleInfo(m_vehicleId, make, model, vin, licencePlate) values (?, ?, ?, ?, ?)", withArgumentsIn: [VehicleInfo.MVehicleId, ciphertext_make, ciphertext_model, ciphertext_vin, ciphertext_licensePlate])
        
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("select last_insert_rowid()", withArgumentsIn: nil)
        
        if (resultSet != nil) {
            while resultSet.next()
            {
                
                // to get last inserted record id
                
                VehicleInfo.V_ID = Int(resultSet.int(forColumnIndex: 0))
                
                print("V_Id:", resultSet.int(forColumnIndex: 0));
                
            }
        }
        
        sharedInstance.database!.close()
        return isInserted
        
    }
    
    
    func getSelectedIdMotorVehicleInfo(contactIdValue: Int) -> NSMutableArray {
        sharedInstance.database!.open()
        let motorVehicleInfoArray : NSMutableArray = NSMutableArray()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM motorVehicleInfo where m_vehicleId=?", withArgumentsIn: [contactIdValue])
        
        if(resultSet != nil)
        {
            while resultSet.next()
            {
                let motorVehicleObject:MotorVehicleInfo = MotorVehicleInfo()
                motorVehicleObject.MVehicleId = Int(resultSet.int(forColumn: "m_vehicleId"))
                motorVehicleObject.V_ID = Int(resultSet.int(forColumn: "v_id"))
                
                // decrypt data
                let password = "dalmet123"
                
                do {
                    
                    if let make =  resultSet.data(forColumn: "make"){
                        
                        let originalData_make = try RNCryptor.decrypt(data: make, withPassword: password)
                        let Make = NSString(data: originalData_make, encoding: String.Encoding.utf8.rawValue)
                        
                        motorVehicleObject.Make = Make! as String
                    }
                    if let model = resultSet.data(forColumn: "model"){
                        
                        let originalData_model = try RNCryptor.decrypt(data: model, withPassword: password)
                        let Model = NSString(data: originalData_model, encoding: String.Encoding.utf8.rawValue)
                        
                        motorVehicleObject.Model = Model! as String
                    }
                    if let vin = resultSet.data(forColumn: "vin"){
                        
                        let originalData_vin = try RNCryptor.decrypt(data: vin, withPassword: password)
                        let Vin = NSString(data: originalData_vin, encoding: String.Encoding.utf8.rawValue)
                        
                        motorVehicleObject.VIN = Vin! as String
                    }
                    
                    if let licensePlate = resultSet.data(forColumn: "licencePlate"){
                        
                        let originalData_licensePlate = try RNCryptor.decrypt(data: licensePlate, withPassword: password)
                        let LicensePlate = NSString(data: originalData_licensePlate, encoding: String.Encoding.utf8.rawValue)
                        
                        motorVehicleObject.LicensePlate = LicensePlate! as String
                    }
                    
                    
                } catch  {
                    print(error)
                }
                
                motorVehicleInfoArray.add(motorVehicleObject)
                
                
                
            }
            
        }
        
        sharedInstance.database!.close()
        return motorVehicleInfoArray
    }
    
    
    
    func getAllMotorVehicleData() -> NSMutableArray {
        
        sharedInstance.database!.open()
        let motorVehicleInfoArray : NSMutableArray = NSMutableArray()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM motorVehicleInfo", withArgumentsIn: nil)
        
        if(resultSet != nil)
        {
            while resultSet.next()
            {
                let motorVehicleObject:MotorVehicleInfo = MotorVehicleInfo()
                motorVehicleObject.MVehicleId = Int(resultSet.int(forColumn: "m_vehicleId"))
                motorVehicleObject.V_ID = Int(resultSet.int(forColumn: "v_id"))
                
                // decrypt data
                let password = "dalmet123"
                
                do {
                    
                    if let make =  resultSet.data(forColumn: "make"){
                        
                        let originalData_make = try RNCryptor.decrypt(data: make, withPassword: password)
                        let Make = NSString(data: originalData_make, encoding: String.Encoding.utf8.rawValue)
                        
                        motorVehicleObject.Make = Make! as String
                    }
                    if let model = resultSet.data(forColumn: "model"){
                        
                        let originalData_model = try RNCryptor.decrypt(data: model, withPassword: password)
                        let Model = NSString(data: originalData_model, encoding: String.Encoding.utf8.rawValue)
                        
                        motorVehicleObject.Model = Model! as String
                    }
                    if let vin = resultSet.data(forColumn: "vin"){
                        
                        let originalData_vin = try RNCryptor.decrypt(data: vin, withPassword: password)
                        let Vin = NSString(data: originalData_vin, encoding: String.Encoding.utf8.rawValue)
                        
                        motorVehicleObject.VIN = Vin! as String
                    }
                    
                    if let licensePlate = resultSet.data(forColumn: "licencePlate"){
                        
                        let originalData_licensePlate = try RNCryptor.decrypt(data: licensePlate, withPassword: password)
                        let LicensePlate = NSString(data: originalData_licensePlate, encoding: String.Encoding.utf8.rawValue)
                        
                        motorVehicleObject.LicensePlate = LicensePlate! as String
                    }
                    
                    
                } catch  {
                    print(error)
                }
           
                motorVehicleInfoArray.add(motorVehicleObject)
                
              
                
            }
            
        }
        
        sharedInstance.database!.close()
        return motorVehicleInfoArray
    }
    
    
    
    // deleteMotorVehicleInfoById
    func deleteMotorVehicleInfoById(_ vehicleInfo: MotorVehicleInfo) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM motorVehicleInfo WHERE m_vehicleId=? AND v_id=?", withArgumentsIn: [vehicleInfo.MVehicleId, vehicleInfo.V_ID])
        sharedInstance.database!.close()
        return isDeleted
    }

    
    func updateVehicleData(_ vehicleInfo: MotorVehicleInfo) -> Bool {
         sharedInstance.database!.open()
        
        // encrypt data
        
        let password = "dalmet123"
        
        let make = vehicleInfo.Make
        let model = vehicleInfo.Model
        let vin = vehicleInfo.VIN
        let licensePlate = vehicleInfo.LicensePlate
        
        let data_make: NSData = make.data(using: .utf8)! as NSData
        let data_model: NSData = model.data(using: .utf8)! as NSData
        let data_vin: NSData = vin.data(using: .utf8)! as NSData
        let data_licensePlate: NSData = licensePlate.data(using: .utf8)! as NSData
        
        
        let ciphertext_make = RNCryptor.encrypt(data: data_make as Data, withPassword: password)
        let ciphertext_model = RNCryptor.encrypt(data: data_model as Data, withPassword: password)
        let ciphertext_vin = RNCryptor.encrypt(data: data_vin as Data, withPassword: password)
        let ciphertext_licensePlate = RNCryptor.encrypt(data: data_licensePlate as Data, withPassword: password)
        
        
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE motorVehicleInfo SET make=?, model=?, vin=?, licencePlate=? WHERE m_vehicleId=? AND v_id=?", withArgumentsIn: [ciphertext_make, ciphertext_model, ciphertext_vin, ciphertext_licensePlate, vehicleInfo.MVehicleId,vehicleInfo.V_ID])
        return isUpdated
        
    }
    
}
