//
//  MedicalInfoViewController.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 23/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class MedicalInfoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,MGSwipeTableCellDelegate {

    var leftContainerView = UIView()
    var leftButton = UIButton()
    var MedicalInfoArray : NSMutableArray!
   
    var person : personalContact!
    var medical: MedicalInfo!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var MedicalInfoTableViewObject: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Medical Info"
        
        errorLabel.isHidden = true
        
         
        self.navigationController?.navigationBar.isHidden=false;
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        leftContainerView = UIView(frame: CGRect(x: 0, y: 6, width: 40, height: 32))
        leftButton = UIButton(type:.custom)
        leftButton = UIButton(frame: CGRect(x: 0, y: 6, width: 40, height: 32))
        leftButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        leftButton.addTarget(self, action: #selector(goToBackViewController), for: UIControlEvents.touchUpInside)
        leftContainerView.addSubview(leftButton)
        
        
      
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "add"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(rightBarButtonTapped))
            
        // Adding button to navigation bar (rightBarButtonItem)
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        MedicalInfoTableViewObject.tableFooterView = UIView(frame: .zero)
        
        
        
    }
    
    func rightBarButtonTapped()  {
       
        
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "createMedicalInfoViewController") as! createMedicalInfoViewController
      //  nextViewController.personContactData=person
        ModelManager.getInstance().Medical_ContactData = person
        nextViewController.personContactData = ModelManager.getInstance().Medical_ContactData
        ModelManager.getInstance().insert_New_MedicalRecord_Flag = true
        self.navigationController?.pushViewController(nextViewController, animated: true)

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        
        if ModelManager.getInstance().myinfo_flag{
            
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.rightBarButtonItem?.isEnabled = false

        }
        else{
        
            
            let barButtonItem = UIBarButtonItem(image: UIImage(named: "add"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(rightBarButtonTapped))
            
            // Adding button to navigation bar (rightBarButtonItem )
            self.navigationItem.rightBarButtonItem = barButtonItem
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            
        }
        
        self.getMedicalInfoData()
        
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
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        if ModelManager.getInstance().edit_flag
        {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CatagoriesViewController") as! CatagoriesViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        else{
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CatagoriesViewController") as! CatagoriesViewController
          self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        
   
        
        
        
       
        
    }
    func getMedicalInfoData()  {
        
        MedicalInfoArray = NSMutableArray()
       
        if ModelManager.getInstance().medical_update_flag  // after medical data update
        {
          
           // let contactIdValue = medical.MedicalInfoId
            
            let contactIdValue = person.contactId

            MedicalInfoArray = ModelManager.getInstance().getSelectedIdMedicalInfo(contactIdValue:contactIdValue)
            
            
        }
        else if ModelManager.getInstance().myinfo_flag
        {
//            if ModelManager.getInstance().insert_New_MedicalRecord_Flag
//            {
//                let contactIdValue = person.contactId
//                print("Id value",contactIdValue)
//                
//                MedicalInfoArray = ModelManager.getInstance().getSelectedIdMedicalInfo(contactIdValue:contactIdValue)
//            }
//            else{
//                
//                let contactIdValue = person.contactId
//                print("Id value",contactIdValue)
//                
//                MedicalInfoArray = ModelManager.getInstance().getSelectedIdMedicalInfo(contactIdValue:contactIdValue)
//            }
//            
            let contactIdValue = person.contactId
            print("Id value",contactIdValue)
    
            MedicalInfoArray = ModelManager.getInstance().getSelectedIdMedicalInfo(contactIdValue:contactIdValue)
           
        }
        else if ModelManager.getInstance().edit_flag
        {   // edit_flag
            
            if ModelManager.getInstance().insert_New_MedicalRecord_Flag
            {
                
                let contactIdValue = person.contactId
                print("Id value",contactIdValue)
        
                MedicalInfoArray = ModelManager.getInstance().getSelectedIdMedicalInfo(contactIdValue:contactIdValue)
            }
            else{
                
                let contactIdValue = person.contactId
                MedicalInfoArray = ModelManager.getInstance().getSelectedIdMedicalInfo(contactIdValue:contactIdValue)
                
            }
            
            
        }
      
        
        if MedicalInfoArray.count == 0
        {
            errorLabel.isHidden = false
        }
        else{
            errorLabel.isHidden = true
        }
        
        
       
        print("Count :",MedicalInfoArray.count)
        MedicalInfoTableViewObject.dataSource = self
        MedicalInfoTableViewObject.delegate = self
        MedicalInfoTableViewObject.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MedicalInfoArray.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return 105
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        var cell: ContactInfoTableViewCell!
        cell = MedicalInfoTableViewObject.dequeueReusableCell(withIdentifier: "medical") as! ContactInfoTableViewCell
        let person_Medical_Info:MedicalInfo = MedicalInfoArray.object(at: indexPath.row) as! MedicalInfo
        
        cell.primaryPhysicianNameLabel.text = person_Medical_Info.PrimaryPhysicianName as String
        cell.physicianAddressLabel.text = person_Medical_Info.PrimaryPhysicianAddress as String
        cell.diseaseLabel.text = person_Medical_Info.Disease as String
        
        cell.delegate=self;
        
        //configure right buttons
        cell.rightButtons = [MGSwipeButton(title: "", icon: UIImage(named:"trash"), backgroundColor: .red), MGSwipeButton(title: "", icon: UIImage(named:"edit"), backgroundColor: .blue)]
        cell.rightSwipeSettings.transition = .drag
        
        
        return cell
        
        
   }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let person_MedicalInfoObject = MedicalInfoArray[indexPath.row] as! MedicalInfo
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "createMedicalInfoViewController") as! createMedicalInfoViewController
        nextViewController.personMedicalData=person_MedicalInfoObject
        ModelManager.getInstance().insert_New_MedicalRecord_Flag = false
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
    }
    func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool
    {
        switch index
        {
        case 0  :
            // delete action
            let alertController = UIAlertController(title:nil, message: "Are you sure you want to delete this person medical info?", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
                
                
                let cellIndexPath = self.MedicalInfoTableViewObject.indexPath(for: cell)
                
                let value:Int = (cellIndexPath?.row)!
                
                let personMedicalObject = self.MedicalInfoArray[value] as! MedicalInfo
                
                let isDeleted = ModelManager.getInstance().deletePersonMedicalDataById(personMedicalObject)
                
                
                if isDeleted {
                    Util.invokeAlertMethod("", strBody: "Person medical record deleted successfully.", delegate: nil)
                } else {
                    Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
                }
                self.getMedicalInfoData()
                
            }))
            
            alertController.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            present(alertController, animated: true, completion: nil)
            
            
        case 1  :
            
            let cellIndexPath = self.MedicalInfoTableViewObject.indexPath(for: cell)
            
            let value:Int = (cellIndexPath?.row)!
            
            let editPersonMedicalObject = MedicalInfoArray[value] as! MedicalInfo
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "createMedicalInfoViewController") as! createMedicalInfoViewController
            
            nextViewController.personMedicalData=editPersonMedicalObject
             ModelManager.getInstance().insert_New_MedicalRecord_Flag = false
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
            
            
        default :
            print( "default case")
        }
        return true
    }
    

    
    func swipeTableCell(_ cell: MGSwipeTableCell, canSwipe direction: MGSwipeDirection) -> Bool {
        return true;
    }

}
