//
//  ContactInfoViewController.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 22/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class ContactInfoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,MGSwipeTableCellDelegate {

    var leftContainerView = UIView()
    var leftButton = UIButton()
    var ContactInfoArray : NSMutableArray!
    var person : personalContact!
    
    
    @IBOutlet weak var contactInfoTableViewObject: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Contact Info"
        
        self.navigationController?.navigationBar.isHidden=false;
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        contactInfoTableViewObject.tableFooterView = UIView(frame: .zero)
        
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
        
        self.getAllSelectedContactData()
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
        
        if ModelManager.getInstance().create_flag
        {
            
//            let myContcatArray: NSMutableArray
//            
//            myContcatArray = ModelManager.getInstance().getAllContactInfoData()
//            
//            if myContcatArray.count == 0 // when no contact record present, then redirect to create contact page
//            {
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreateInfoViewController") as! CreateInfoViewController
//                self.navigationController?.pushViewController(nextViewController, animated: true)
//                
//            }
//            else{
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CatagoriesViewController") as! CatagoriesViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
           // }
            
            
        }
        
        if ModelManager.getInstance().edit_flag
        {
            
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }

            
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CatagoriesViewController") as! CatagoriesViewController
//            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        
        
    }

    func getAllSelectedContactData()  {
        
        ContactInfoArray = NSMutableArray()
        
        let contactIdValue = person.contactId
        print("Value:", contactIdValue)
        ContactInfoArray = ModelManager.getInstance().getAllSelectedContactInfoData(contactIdValue: contactIdValue)
        
        contactInfoTableViewObject.dataSource = self
        contactInfoTableViewObject.delegate = self

        
        contactInfoTableViewObject.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ContactInfoArray.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return 105
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        var cell: ContactInfoTableViewCell!
        cell = contactInfoTableViewObject.dequeueReusableCell(withIdentifier: "contact") as! ContactInfoTableViewCell
        let person_Contact:personalContact = ContactInfoArray.object(at: indexPath.row) as! personalContact
        
        cell.firstNameLabel.text = person_Contact.FirstName
        cell.lastNameLabel.text = person_Contact.LastName
        cell.emailLabel.text = person_Contact.Email
        
        cell.delegate=self;
        
        //configure right buttons
        cell.rightButtons = [MGSwipeButton(title: "", icon: UIImage(named:"edit"), backgroundColor: .blue)]
        cell.rightSwipeSettings.transition = .drag
        
             
        return cell
        
        
    }
    
    func swipeTableCell(_ cell: MGSwipeTableCell, canSwipe direction: MGSwipeDirection) -> Bool {
        return true;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        
        let editPersonObject = ContactInfoArray[indexPath.row] as! personalContact
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreateUserInfoViewController") as! CreateUserInfoViewController
        
        nextViewController.personContactData=editPersonObject
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
       
        
    }
    func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool
    {
        switch index
        {
     
            
            
        case 0  :
            
            let cellIndexPath = self.contactInfoTableViewObject.indexPath(for: cell)
            
            let value:Int = (cellIndexPath?.row)!
            
            let editPersonObject = ContactInfoArray[value] as! personalContact
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CreateUserInfoViewController") as! CreateUserInfoViewController
            
            nextViewController.personContactData=editPersonObject
          
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
            
            
        default :
            print( "default case")
        }
        return true
    }
    
    
    
}
