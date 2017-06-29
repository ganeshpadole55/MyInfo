//
//  MotorVehicleInfoViewController.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 24/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class MotorVehicleInfoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,MGSwipeTableCellDelegate {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var MotorVehicleTableViewObject: UITableView!
    var leftContainerView = UIView()
    var leftButton = UIButton()
    var MotorVehicleInfoArray : NSMutableArray!
    
    var person: personalContact!
    var motor: MotorVehicleInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Motor Vehicle Info"
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
        
        
        
        MotorVehicleTableViewObject.tableFooterView = UIView(frame: .zero)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rightBarButtonTapped()  {
        
        
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "createVehicleInfoViewController") as! createVehicleInfoViewController
        
        nextViewController.personContactData=person
        ModelManager.getInstance().Medical_ContactData = person
        nextViewController.personContactData = ModelManager.getInstance().Medical_ContactData
        ModelManager.getInstance().insert_New_VehicleRecord_Flag = true
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
        
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
        
        
        self.getMotorVehicleData()
        
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
  
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CatagoriesViewController") as! CatagoriesViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
      
        
       
        
    }
    func getMotorVehicleData()  {
        
        MotorVehicleInfoArray = NSMutableArray()
        
        if ModelManager.getInstance().vehicle_update_flag  // after motor vehicle data update
        {
            
           let contactIdValue = person.contactId
            MotorVehicleInfoArray = ModelManager.getInstance().getSelectedIdMotorVehicleInfo(contactIdValue:contactIdValue)
            
            
        }
        else if ModelManager.getInstance().myinfo_flag
        {
            
//            if ModelManager.getInstance().insert_New_MedicalRecord_Flag
//            {
//                let contactIdValue = person.contactId
//                
//                MotorVehicleInfoArray = ModelManager.getInstance().getSelectedIdMotorVehicleInfo(contactIdValue:contactIdValue)
//            }
//            else{
            
                let contactIdValue = person.contactId
                
                MotorVehicleInfoArray = ModelManager.getInstance().getSelectedIdMotorVehicleInfo(contactIdValue:contactIdValue)
           // }
            
            
          
        }
        else if ModelManager.getInstance().edit_flag{
            // edit_flag
            
            if ModelManager.getInstance().insert_New_MedicalRecord_Flag
            {
                let contactIdValue = person.contactId
                
                MotorVehicleInfoArray = ModelManager.getInstance().getSelectedIdMotorVehicleInfo(contactIdValue:contactIdValue)
            }
            else{
                
                let contactIdValue = person.contactId
                
                MotorVehicleInfoArray = ModelManager.getInstance().getSelectedIdMotorVehicleInfo(contactIdValue:contactIdValue)
            }
            
           
        }
       
        

       // MotorVehicleInfoArray = ModelManager.getInstance().getAllMotorVehicleData()
        
        print("Count :",MotorVehicleInfoArray.count)
        
        if MotorVehicleInfoArray.count == 0
        {
        
            errorLabel.isHidden = false
        }
        else{
            errorLabel.isHidden = true
        }
        
        MotorVehicleTableViewObject.dataSource = self
        MotorVehicleTableViewObject.delegate = self
        MotorVehicleTableViewObject.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MotorVehicleInfoArray.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return 135
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        var cell: ContactInfoTableViewCell!
        cell = MotorVehicleTableViewObject.dequeueReusableCell(withIdentifier: "motorvehicle") as! ContactInfoTableViewCell
        let motor_Vehicle_Info:MotorVehicleInfo = MotorVehicleInfoArray.object(at: indexPath.row) as! MotorVehicleInfo
        
        cell.MakeLabel.text = motor_Vehicle_Info.Make as String
        cell.ModelLabel.text = motor_Vehicle_Info.Model as String
        cell.VINLabel.text = motor_Vehicle_Info.VIN as String
        cell.LicensePlateLabel.text = motor_Vehicle_Info.LicensePlate as String
        
        
        cell.delegate=self;
        
        //configure right buttons
        cell.rightButtons = [MGSwipeButton(title: "", icon: UIImage(named:"trash"), backgroundColor: .red), MGSwipeButton(title: "", icon: UIImage(named:"edit"), backgroundColor: .blue)]
        cell.rightSwipeSettings.transition = .drag
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
       
        let motorVehicleInfoObject = MotorVehicleInfoArray[indexPath.row] as! MotorVehicleInfo
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "createVehicleInfoViewController") as! createVehicleInfoViewController
        nextViewController.motorVehicleInfo=motorVehicleInfoObject
        ModelManager.getInstance().insert_New_VehicleRecord_Flag = false
        ModelManager.getInstance().vehicle_update_flag = false
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
    }
    func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool
    {
        switch index
        {
        case 0  :
            // delete action
            let alertController = UIAlertController(title:nil, message: "Are you sure you want to delete this person motor vehicle info?", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
                
                
                let cellIndexPath = self.MotorVehicleTableViewObject.indexPath(for: cell)
                
                let value:Int = (cellIndexPath?.row)!
                
                let motorVehicleObject = self.MotorVehicleInfoArray[value] as! MotorVehicleInfo
                
                let isDeleted = ModelManager.getInstance().deleteMotorVehicleInfoById(motorVehicleObject)
                
                
                if isDeleted {
                    
                     self.getMotorVehicleData()
                    
                    Util.invokeAlertMethod("", strBody: "Person motor vehicle record deleted successfully.", delegate: nil)
                } else {
                    Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
                }
               
                
            }))
            
            alertController.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            present(alertController, animated: true, completion: nil)
            
            
        case 1  :
            
            let cellIndexPath = self.MotorVehicleTableViewObject.indexPath(for: cell)
            
            let value:Int = (cellIndexPath?.row)!
            
            let editMotorVehicleObject = MotorVehicleInfoArray[value] as! MotorVehicleInfo
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "createVehicleInfoViewController") as! createVehicleInfoViewController
            
            nextViewController.motorVehicleInfo=editMotorVehicleObject
            ModelManager.getInstance().insert_New_VehicleRecord_Flag = false
            ModelManager.getInstance().vehicle_update_flag = false
            
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
