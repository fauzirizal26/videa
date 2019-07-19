//
//  PertanyaanCell.swift
//  vlidea
//
//  Created by Fauzi Rizal on 19/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit

protocol PertanyaanCellDelegate: class {
    func textViewFilled(withValue: String, withTextViewName: String)
}

class PertanyaanCell: UITableViewCell, UITextViewDelegate {
    
    // outlets
    @IBOutlet weak var pembukaanDanPenutupanTextView: UITextView!
    @IBOutlet weak var klimaksTextView: UITextView!
    @IBOutlet weak var alurCeritaTextView: UITextView!
    @IBOutlet weak var selesaiButton: UIButton!
    
    
    // variables    
    weak var delegate: PertanyaanCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        pembukaanDanPenutupanTextView.textColor = UIColor.lightGray
        klimaksTextView.textColor = UIColor.lightGray
        alurCeritaTextView.textColor = UIColor.lightGray
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == pembukaanDanPenutupanTextView {
            self.delegate?.textViewFilled(withValue: textView.text!, withTextViewName: "pembukaan")
        } else if textView == klimaksTextView {
            self.delegate?.textViewFilled(withValue: textView.text!, withTextViewName: "klimaks")
        } else {
            self.delegate?.textViewFilled(withValue: textView.text!, withTextViewName: "alur")
        }
        
    }
    
    
}
