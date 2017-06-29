//
//  MyInfoViewController.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 16/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit
import SideMenu
import MGSwipeTableCell

class MyInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MGSwipeTableCellDelegate {

    var attrs = [
        NSFontAttributeName : UIFont.systemFont(ofSize: 17.0),
      //  NSForegroundColorAttributeName : UIColor.red,
        NSUnderlineStyleAttributeName : 1] as [String : Any]
    var attributedString = NSMutableAttributedString(string:"")
    
    
  
    var myInfoArray : NSMutableArray!    // self
    var myFamilyMemberArray : NSMutableArray!   // for family member
    
    
    var leftContainerView = UIView()
    var leftButton = UIButton()
    
    @IBOutlet weak var addFamilyMemberButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var addMemberLabel: UILabel!
    
    var myFamily : NSMutableArray!
    
    
    @IBOutlet weak var FamilyMemberTableViewObject: UITableView!
    
    @IBOutlet weak var SelfInfoButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="My Info"
        
        errorLabel.isHidden = true
        
        self.navigationController?.navigationBar.isHidden=false;
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        FamilyMemberTableViewObject.tableFooterView = UIView(frame: .zero)
        
        addFamilyMemberButton.clipsToBounds = true
        addFamilyMemberButton.layer.cornerRadius = addFamilyMemberButton.layer.frame.size.width/2
        addFamilyMemberButton.layer.borderWidth = 2
        addFamilyMemberButton.layer.borderColor = UIColor.lightGray.cgColor
        
        /*
         
         button.backgroundColor = .clear
         button.layer.cornerRadius = 5
         button.layer.borderWidth = 1
         button.layer.borderColor = UIColor.black.cgColor

         */
        
        if ModelManager.getInstance().myinfo_flag   // show add family button
        {
            addMemberLabel.isHidden = false
            addFamilyMemberButton.isHidden = false
            
        }
        
        if ModelManager.getInstance().edit_flag // hide add family member button
        {
            addMemberLabel.isHidden = true
            addFamilyMemberButton.isHidden = true
 
        
        }
        
      //  getFamilyMemberList()
        
        
        let buttonTitleStr = NSMutableAttributedString(string:"Self", attributes:attrs)
        attributedString.append(buttonTitleStr)
        SelfInfoButton.setAttributedTitle(attributedString, for: .normal)
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 71.0/255.0, green: 176.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        leftContainerView = UIView(frame: CGRect(x: 0, y: 6, width: 40, height: 32))
        leftButton = UIButton(type:.custom)
        leftButton = UIButton(frame: CGRect(x: 0, y: 6, width: 40, height: 32))
        leftButton.setImage(UIImage(named: "menu_list")?.withRenderingMode(.alwaysOriginal), for: .normal)
        leftButton.addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
        leftContainerView.addSubview(leftButton)
        

        
    }

        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
        
        SideMenuManager.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
      //  SideMenuManager.menuAllowPushOfSameClassTwice = false
  
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        navigationController?.navigationBar.addSubview(leftContainerView)
        navigationController?.navigationBar.addSubview(leftButton)
        
        self.errorLabel.isHidden = true
        // loder start
        
        getFamilyMemberList()
        
        if ModelManager.getInstance().myinfo_flag   // show add family button
        {
            addMemberLabel.isHidden = false
            addFamilyMemberButton.isHidden = false
            
        }
        
        if ModelManager.getInstance().edit_flag // hide add family member button
        {
            addMemberLabel.isHidden = true
            addFamilyMemberButton.isHidden = true
            
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        leftContainerView.removeFromSuperview()
        leftButton.removeFromSuperview()
    }
    

    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBAction func SelfInfoButtonPressed(_ sender: Any) {
        
       
        let name = "Self" as String
        myFamilyMemberArray = NSMutableArray()
        myFamilyMemberArray = ModelManager.getInstance().getMyOwnData(name:name as String)
        
        print(myFamilyMemberArray.count)
        
        if myFamilyMemberArray.count == 0
        {
            Util.invokeAlertMethod("Alert", strBody: "No Record Found.", delegate: nil)
            return
        }
        else{
           
            let person_Own_Info:personalContact = myFamilyMemberArray.object(at: 0) as! personalContact
            
            print( person_Own_Info.FirstName)
            print(person_Own_Info.LastName)
            print( person_Own_Info.City)
            print( person_Own_Info.State)
            
                    
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CatagoriesViewController") as! CatagoriesViewController
            ModelManager.getInstance().myInfo_self_familyMemberFlag = true
            nextViewController.myInfoContactData=person_Own_Info
            ModelManager.getInstance().Medical_ContactData = person_Own_Info
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
       
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myInfoArray.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        var cell: FamilyMemberTableViewCell!
        
        cell = FamilyMemberTableViewObject.dequeueReusableCell(withIdentifier: "familymember") as! FamilyMemberTableViewCell
        
        let person_Contact:personalContact = myInfoArray.object(at: indexPath.row) as! personalContact
        
        cell.familyMemberNameLabel.text = person_Contact.FirstName
        cell.memberRelationLabel.text = person_Contact.Relation
        
        cell.delegate=self;
        
        
        if ModelManager.getInstance().myinfo_flag
        {
            
            //configure right buttons
            cell.rightButtons = [MGSwipeButton(title: "", icon: UIImage(named:"edit"), backgroundColor: .blue)]
            cell.rightSwipeSettings.transition = .drag
            
        }
        if ModelManager.getInstance().edit_flag
        {
            //configure right buttons
            cell.rightButtons = [MGSwipeButton(title: "", icon: UIImage(named:"trash"), backgroundColor: .red), MGSwipeButton(title: "", icon: UIImage(named:"edit"), backgroundColor: .blue)]
            cell.rightSwipeSettings.transition = .drag
            
        }
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            let person_Own_Info:personalContact = myInfoArray.object(at: indexPath.row) as! personalContact
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CatagoriesViewController") as! CatagoriesViewController
       
            nextViewController.myInfoContactData=person_Own_Info
        
            ModelManager.getInstance().Medical_ContactData = person_Own_Info
            ModelManager.getInstance().vehicle_update_flag = false
        
            self.navigationController?.pushViewController(nextViewController, animated: true)
         
        
    }
    
    @IBAction func AddFamilyMember(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreateInfoViewController") as! CreateInfoViewController
       
        ModelManager.getInstance().myinfo_flag = false
        ModelManager.getInstance().create_flag = true
        ModelManager.getInstance().edit_flag = false
        ModelManager.getInstance().requestInfoFlag = false
        
        self.navigationController?.pushViewController(nextViewController, animated: true)

        
    }
   
    func getFamilyMemberList()   {
        
        
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
                spinnerActivity.label.text = "Loading";
        spinnerActivity.detailsLabel.text = "Please Wait!!";
        spinnerActivity.isUserInteractionEnabled = false;
        
        
       
        DispatchQueue.global(qos: .background).async{
            // Add some background task like image download, wesite loading.
            
            self.myInfoArray = NSMutableArray()
            
            
            self.myInfoArray = ModelManager.getInstance().getPersonName_RelationInfoData()
            
            DispatchQueue.main.async()
            {
                self.FamilyMemberTableViewObject.dataSource = self
                self.FamilyMemberTableViewObject.delegate = self
                self.FamilyMemberTableViewObject.reloadData()
                
                
                print("Total Count:",self.myInfoArray.count)
                
                if self.myInfoArray.count == 0
                {
                    self.errorLabel.isHidden = false
                    
                }
                else{
                    
                    self.errorLabel.isHidden = true
                }
                
                
                spinnerActivity.hide(animated: true);
           }
        
        
        }
        
       
        
        
       

        
    }
    
    func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool
    {
        if ModelManager.getInstance().myinfo_flag   // show only edit option
        {
            
            switch index {
            case 0:
                
                let cellIndexPath = self.FamilyMemberTableViewObject.indexPath(for: cell)
                
                let value:Int = (cellIndexPath?.row)!
                
                let editPersonObject = myInfoArray[value] as! personalContact
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CatagoriesViewController") as! CatagoriesViewController
                
                nextViewController.myInfoContactData=editPersonObject
                ModelManager.getInstance().vehicle_update_flag = false
                
                ModelManager.getInstance().Medical_ContactData = editPersonObject
                
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            default :
                
                print( "default case")
            }
                
            }
            
            
       
        
        if ModelManager.getInstance().edit_flag  // show edit and delete option
        {
            switch index
            {
                
            case 0  :
                // delete action
                let alertController = UIAlertController(title:nil, message: "Are you sure you want to delete this person info?", preferredStyle: UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
                    
                    
                    let cellIndexPath = self.FamilyMemberTableViewObject.indexPath(for: cell)
                    
                    let value:Int = (cellIndexPath?.row)!
                    
                    let personObject = self.myInfoArray[value] as! personalContact
                    
                    let isDeleted = ModelManager.getInstance().deletePersonDataById(personObject)
                    
                    
                    if isDeleted {
                        
                        self.getFamilyMemberList()
                        self.FamilyMemberTableViewObject.reloadData()
                        
                        Util.invokeAlertMethod("", strBody: "Person record deleted successfully.", delegate: nil)
                    } else {
                        Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
                    }
                    
                    
                }))
                
                alertController.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                }))
                
                present(alertController, animated: true, completion: nil)
                
                
            case 1  :
                
                let cellIndexPath = self.FamilyMemberTableViewObject.indexPath(for: cell)
                
                let value:Int = (cellIndexPath?.row)!
                
                let editPersonObject = myInfoArray[value] as! personalContact
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CatagoriesViewController") as! CatagoriesViewController
                
                nextViewController.myInfoContactData=editPersonObject
                ModelManager.getInstance().vehicle_update_flag = false
                
                ModelManager.getInstance().Medical_ContactData = editPersonObject
                
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
                
                
                
            default :
                print( "default case")
            }
            
        }
        return true
        }
        
        
}




