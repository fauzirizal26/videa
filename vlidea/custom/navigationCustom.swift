//
//  navigationCustom.swift
//  vlidea
//
//  Created by Fauzi Rizal on 13/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func buttonKananPlus() {
        let plusButtonView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let plusButton = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 20, height: 20)))
        plusButton.setImage(UIImage(named: "Plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(goToBikinIde), for: .touchUpInside)
        plusButtonView.addSubview(plusButton)
        let plusBarButton = UIBarButtonItem(customView: plusButtonView)
        self.navigationItem.rightBarButtonItem = plusBarButton
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navBar"), for: .default)
    }
    
    func closeButtonKanan() {
        let closeButtonView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let closeButton = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 20, height: 20)))
        closeButton.setImage(UIImage(named: "crossPutih"), for: .normal)
        closeButton.addTarget(self, action: #selector(goToRootViewController), for: .touchUpInside)
        closeButtonView.addSubview(closeButton)
        let closeBarButton = UIBarButtonItem(customView: closeButtonView)
        self.navigationItem.rightBarButtonItem = closeBarButton
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navBar"), for: .default)
        
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    
    @objc func goToBikinIde() {
        performSegue(withIdentifier: "goToBikinIdeVC", sender: self)
    }
    @objc func goToRootViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
