//
//  CookieLocationCell.swift
//  CookieMeUp
//
//  Created by Raquel Figueroa-Opperman on 4/29/18.
//  Copyright © 2018 CSUMB-CST495-Group-1. All rights reserved.
//

import UIKit

class CookieLocationCell: UITableViewCell {

    @IBOutlet weak var long: UILabel!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var user: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
