//
//  PertanyaanCell.swift
//  vlidea
//
//  Created by Fauzi Rizal on 19/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit

class PertanyaanCell: UITableViewCell {
    
    // outlets
    @IBOutlet weak var pembukaanDanPenutupanTextView: UITextView!
    @IBOutlet weak var klimaksTextView: UITextView!
    @IBOutlet weak var alurCeritaTextView: UITextView!
    @IBOutlet weak var selesaiButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
