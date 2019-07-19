//
//  StorylineCell.swift
//  vlidea
//
//  Created by Fauzi Rizal on 14/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit

class StorylineCell: UITableViewCell {
    
    // outlets
    @IBOutlet weak var pembukaanDanPenutupanLabel: UILabel!
    @IBOutlet weak var klimaksLabel: UILabel!
    @IBOutlet weak var alurCeritaLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
