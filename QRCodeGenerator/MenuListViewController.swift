//
//  MenuListViewController.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 26/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit


class MenuListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var menuTableViewObject: UITableView!
    
    var menuNames = ["myinfo","createform","editform","requestinfo","logout"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuTableViewObject.dataSource=self
        menuTableViewObject.delegate = self
        
        menuTableViewObject.tableFooterView = UIView() // hide empty cell in tableview
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuNames.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        if indexPath.row == 0
        {
        
            return 125
        }
        else{
            
            return 50
        }
       
        
        
    }
    
    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       
        if indexPath.row == 0 // MyInfo Menu Pressed
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyInfoViewController") as! MyInfoViewController
            
            ModelManager.getInstance().myinfo_flag = true
            ModelManager.getInstance().create_flag = false
            ModelManager.getInstance().edit_flag = false
            ModelManager.getInstance().requestInfoFlag = false
            
            self.navigationController?.pushViewController(nextViewController, animated: true)

        
        }
        
        
        if indexPath.row == 1 // Create Menu Pressed
        {
        
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreateInfoViewController") as! CreateInfoViewController
            
            ModelManager.getInstance().myinfo_flag = false
            ModelManager.getInstance().create_flag = true
            ModelManager.getInstance().edit_flag = false
            ModelManager.getInstance().requestInfoFlag = false
            ModelManager.getInstance().insert_New_VehicleRecord_Flag = false
            ModelManager.getInstance().insert_New_MedicalRecord_Flag = false
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
        if indexPath.row == 2  // Edit Menu pressed
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyInfoViewController") as! MyInfoViewController
            
            ModelManager.getInstance().myinfo_flag = false
            ModelManager.getInstance().create_flag = false
            ModelManager.getInstance().edit_flag = true
            ModelManager.getInstance().requestInfoFlag = false
            
           
            ModelManager.getInstance().medical_update_flag = false
            ModelManager.getInstance().vehicle_update_flag = false
            
            self.navigationController?.pushViewController(nextViewController, animated: true)

        }
        if indexPath.row == 3 // Request Info menu pressed
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CatagoriesViewController") as! CatagoriesViewController
            
            ModelManager.getInstance().myinfo_flag = false
            ModelManager.getInstance().create_flag = false
            ModelManager.getInstance().edit_flag = false
            ModelManager.getInstance().requestInfoFlag = true
            
            
            self.navigationController?.pushViewController(nextViewController, animated: true)

        }
        
        if indexPath.row == 4 // Logout menu pressed
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
        

        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        
        var cell: MenuTableViewCell!
        
        if indexPath.row==0
        {
            cell = menuTableViewObject.dequeueReusableCell(withIdentifier: "myinfo") as! MenuTableViewCell
            
            cell.setMyInfoName()
            return cell
        }
        
        if indexPath.row==1
        {
            cell = menuTableViewObject.dequeueReusableCell(withIdentifier: "createform") as! MenuTableViewCell
            
            cell.setCreateFormName()
            return cell
        }
        
        if indexPath.row==2
        {
            cell = menuTableViewObject.dequeueReusableCell(withIdentifier: "editform") as! MenuTableViewCell
            
            cell.setEditFormName()
            return cell
        }
        if indexPath.row==3
        {
            cell = menuTableViewObject.dequeueReusableCell(withIdentifier: "requestinfo") as! MenuTableViewCell
            
            cell.setRequestInfoName()
            return cell
        }
        if indexPath.row==4
        {
            cell = menuTableViewObject.dequeueReusableCell(withIdentifier: "logout") as! MenuTableViewCell
            
            cell.setLogOutName()
            return cell
        }
        
        
        
        return cell
    }
    
   
   

}
