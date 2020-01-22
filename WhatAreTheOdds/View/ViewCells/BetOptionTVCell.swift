//
//  BetOptionTVCell.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 1/20/20.
//  Copyright © 2020 ramcomw. All rights reserved.
//

import UIKit

class BetOptionTVCell: UITableViewCell {
    @IBOutlet weak var betSelectButton: UIButton!
    @IBOutlet weak var betOptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
