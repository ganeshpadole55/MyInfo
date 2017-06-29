//
//  CatagoriesViewController.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 17/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit

class CatagoriesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var catagoriesArray = [String]()
    
    var leftContainerView = UIView()
    var leftButton = UIButton()
    
    var personContactData : personalContact!
    var myInfoContactData: personalContact!
    
    var myArray: NSMutableArray!
    
    var personArray: NSMutableArray!
    
    @IBOutlet weak var catagoriesTableViewObject: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Catagories"
        
        self.navigationController?.navigationBar.isHidden=false;
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        catagoriesArray = ["Contact","Medical","Employment","Motor Vehicle"]
        catagoriesTableViewObject.tableFooterView = UIView(frame: .zero)
        
        leftContainerView = UIView(frame: CGRect(x: 0, y: 6, width: 40, height: 32))
        leftButton = UIButton(type:.custom)
        leftButton = UIButton(frame: CGRect(x: 0, y: 6, width: 40, height: 32))
        leftButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        leftButton.addTarget(self, action: #selector(goToBackViewController), for: UIControlEvents.touchUpInside)
        leftContainerView.addSubview(leftButton)

            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        
        myInfoContactData = ModelManager.getInstance().Medical_ContactData
        
        personArray = getSelectedPersonInfo(myInfoContactData: myInfoContactData)
        
        navigationController?.navigationBar.addSubview(leftContainerView)
        navigationController?.navigationBar.addSubview(leftButton)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        leftContainerView.removeFromSuperview()
        leftButton.removeFromSuperview()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func goToBackViewController(sender: UIButton!)
    {
        if ModelManager.getInstance().myinfo_flag
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyInfoViewController") as! MyInfoViewController
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        if ModelManager.getInstance().create_flag
        {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyInfoViewController") as! MyInfoViewController
            ModelManager.getInstance().myinfo_flag = true
            ModelManager.getInstance().create_flag = false
            ModelManager.getInstance().edit_flag = false
            ModelManager.getInstance().requestInfoFlag = false
            
            
            
           self.navigationController?.pushViewController(nextViewController, animated: true)
         
        }
        if ModelManager.getInstance().edit_flag
        {
        
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyInfoViewController") as! MyInfoViewController
            
            ModelManager.getInstance().myinfo_flag = true
            ModelManager.getInstance().create_flag = false
            ModelManager.getInstance().edit_flag = false
            ModelManager.getInstance().requestInfoFlag = false
            
            
            
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
        
        if ModelManager.getInstance().requestInfoFlag  // when we tap back button it goes to myinfo
        {
        
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyInfoViewController") as! MyInfoViewController
            
            
            ModelManager.getInstance().myinfo_flag = true
            ModelManager.getInstance().create_flag = false
            ModelManager.getInstance().edit_flag = false
            ModelManager.getInstance().requestInfoFlag = false
            
            
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        
     
       
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catagoriesArray.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        var cell: CatagoriesTableViewCell!
        
        cell = catagoriesTableViewObject.dequeueReusableCell(withIdentifier: "catagories") as! CatagoriesTableViewCell
        
        let cellData = [catagoriesArray[indexPath.row] ] 
        
        cell.showMyCatagories(cellData)
        
        return cell
        
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        if indexPath.row==0 // contact
        {
            
            
            if ModelManager.getInstance().myinfo_flag
            {
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreateUserInfoViewController") as! CreateUserInfoViewController
                
                
                let person_Own_Info:personalContact = personArray.object(at: 0) as! personalContact
                
                ModelManager.getInstance().Medical_ContactData = person_Own_Info
                
                nextViewController.personContactData =  ModelManager.getInstance().Medical_ContactData
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            
            if ModelManager.getInstance().create_flag
            {
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreateUserInfoViewController") as! CreateUserInfoViewController
                
                
                nextViewController.personContactData =  ModelManager.getInstance().sharedContactData
                self.navigationController?.pushViewController(nextViewController, animated: true)

            }
            
            if ModelManager.getInstance().edit_flag
            {
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ContactInfoViewController") as! ContactInfoViewController
                
               // nextViewController.person = myInfoContactData
                let person_Own_Info:personalContact = personArray.object(at: 0) as! personalContact
                
                ModelManager.getInstance().Medical_ContactData = person_Own_Info
                
               nextViewController.person = ModelManager.getInstance().Medical_ContactData
                
                self.navigationController?.pushViewController(nextViewController, animated: true)

            }
            
            if ModelManager.getInstance().requestInfoFlag  // open empty form
            {
            
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreateUserInfoViewController") as! CreateUserInfoViewController
                
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            
            
        }
        
        if indexPath.row==1 // Medical
        {
            
            
            if ModelManager.getInstance().myinfo_flag
            {
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MedicalInfoViewController") as! MedicalInfoViewController
                
                let person_Own_Info:personalContact = personArray.object(at: 0) as! personalContact
                
                ModelManager.getInstance().Medical_ContactData = person_Own_Info
                
                nextViewController.person = ModelManager.getInstance().Medical_ContactData
             
                
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            
          
            if ModelManager.getInstance().create_flag // when create menu pressed
            {
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "createMedicalInfoViewController") as! createMedicalInfoViewController
                
                nextViewController.personContactData=personContactData
                ModelManager.getInstance().create_edit_flag = false
                
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            if ModelManager.getInstance().edit_flag  // when edit menu pressed
            {
            
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MedicalInfoViewController") as! MedicalInfoViewController
                
                let person_Own_Info:personalContact = personArray.object(at: 0) as! personalContact
                
                ModelManager.getInstance().Medical_ContactData = person_Own_Info
                
                
                 nextViewController.person = ModelManager.getInstance().Medical_ContactData
                ModelManager.getInstance().medical_update_flag = false
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            
            if ModelManager.getInstance().requestInfoFlag  // open empty form
            {
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "createMedicalInfoViewController") as! createMedicalInfoViewController
                
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            
        }
        
        if indexPath.row==2 // Employment
        {
            

        }
        if indexPath.row==3 // Motor vehicle
        {
            
            if ModelManager.getInstance().myinfo_flag
            {
            
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MotorVehicleInfoViewController") as! MotorVehicleInfoViewController
                
                let person_Own_Info:personalContact = personArray.object(at: 0) as! personalContact
                
                ModelManager.getInstance().Medical_ContactData = person_Own_Info
                
                
                nextViewController.person = ModelManager.getInstance().Medical_ContactData
                
                
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            
            
            
            if ModelManager.getInstance().create_flag  // when create menu pressed
            {
                
                   let nextViewController = storyBoard.instantiateViewController(withIdentifier: "createVehicleInfoViewController") as! createVehicleInfoViewController
                
                nextViewController.personContactData=personContactData
                ModelManager.getInstance().create_edit_flag = false
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            if ModelManager.getInstance().edit_flag  // when edit menu pressed
            {
            
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MotorVehicleInfoViewController") as! MotorVehicleInfoViewController
                
                let person_Own_Info:personalContact = personArray.object(at: 0) as! personalContact
                
                ModelManager.getInstance().Medical_ContactData = person_Own_Info
                
                
               nextViewController.person = ModelManager.getInstance().Medical_ContactData
                ModelManager.getInstance().vehicle_update_flag = false
                 
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            
            if ModelManager.getInstance().requestInfoFlag   // open empty form
            {
            
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "createVehicleInfoViewController") as! createVehicleInfoViewController
              
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            
        }
        
        
    
    }

    
    func getSelectedPersonInfo(myInfoContactData: personalContact) -> NSMutableArray {
        
        let contactIdValue = myInfoContactData.contactId
        
        personArray = ModelManager.getInstance().getAllSelectedContactInfoData(contactIdValue: contactIdValue)
        return personArray
    }
    
}
