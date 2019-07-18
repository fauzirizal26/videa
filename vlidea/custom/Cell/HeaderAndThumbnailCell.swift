//
//  HeaderAndThumbnailCell.swift
//  vlidea
//
//  Created by Fauzi Rizal on 14/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit

class HeaderAndThumbnailCell: UITableViewCell {
    
    // outlets
    @IBOutlet weak var lockedUnlockedLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailPicture: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
