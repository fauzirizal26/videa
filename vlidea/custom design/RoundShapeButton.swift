//
//  File.swift
//  vlidea
//
//  Created by Fauzi Rizal on 08/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit


class RoundShapeButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        layer.cornerRadius = frame.size.height/2
        
    }
}
