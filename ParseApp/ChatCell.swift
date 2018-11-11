//
//  ChatCell.swift
//  ParseApp
//
//  Created by Sandyna Sandaire Jerome on 11/11/18.
//  Copyright © 2018 Sandyna Sandaire Jerome. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
