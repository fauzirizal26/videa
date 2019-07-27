//
//  ContentCollectionCell.swift
//  vlidea
//
//  Created by Fauzi Rizal on 15/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit

class ContentCollectionCell: UICollectionViewCell {
    
    // outlets
    @IBOutlet weak var lockedUnlockedLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailPicture: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var isInEditingMode: Bool = false {
        didSet {
            //checkmarkLabel.isHidden = !isInEditingMode
        }
    }
    
    // 2
    override var isSelected: Bool {
        didSet {
            if isInEditingMode {
                //checkmarkLabel.text = isSelected ? "✓" : ""
            }
        }
    }

}
