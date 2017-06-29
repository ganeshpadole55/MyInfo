//
//  CatagoriesTableViewCell.swift
//  QRCodeGenerator
//
//  Created by Dalmet-03 on 18/05/17.
//  Copyright © 2017 Dalmet-03. All rights reserved.
//

import UIKit

class CatagoriesTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var catagoriesNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func showMyCatagories(_ name:Array<Any>)
    {
        let nameValue = name[0] as! String
        
        
        catagoriesNameLabel.text = nameValue;
    }

}
