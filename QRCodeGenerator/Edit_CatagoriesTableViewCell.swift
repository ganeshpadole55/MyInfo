//
//  Edit_CatagoriesTableViewCell.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 22/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit

class Edit_CatagoriesTableViewCell: UITableViewCell {

     @IBOutlet weak var Edit_CatagoriesNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    func Edit_showMyCatagories(_ name:Array<Any>)
    {
        let nameValue = name[0] as! String
        
        Edit_CatagoriesNameLabel.text = nameValue;
    }
    
}
