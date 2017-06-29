//
//  MenuTableViewCell.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 26/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var myInfoLabel: UILabel!
    
    @IBOutlet weak var createFormLabel: UILabel!
    
    @IBOutlet weak var editFormLabel: UILabel!
    
    @IBOutlet weak var requestInfoLabel: UILabel!
    
    @IBOutlet weak var logOutLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setMyInfoName()  {
        myInfoLabel.text = "My Info"
        
    }
    func setCreateFormName()  {
        createFormLabel.text = "Create"
    }
    func setEditFormName()  {
        editFormLabel.text = "Edit"
    }
    func setRequestInfoName() {
        requestInfoLabel.text = "Request Info"
        
    }
    
    func setLogOutName()
    {
        logOutLabel.text = "Log Out"
    }
}
