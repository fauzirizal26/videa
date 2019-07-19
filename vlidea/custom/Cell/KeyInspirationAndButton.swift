//
//  KeyInspirationAndButton.swift
//  vlidea
//
//  Created by Fauzi Rizal on 14/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit

class KeyInspirationAndButton: UITableViewCell {
    
    
    // outlets
    @IBOutlet weak var judulLabel: UILabel!
    @IBOutlet weak var onePhraseLabel: UILabel!
    @IBOutlet weak var collabWithLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var uniqueLabel: UILabel!
    @IBOutlet weak var boomingFactorLabel: UILabel!
    @IBOutlet weak var panduanLanjutanButton: UIButton!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
