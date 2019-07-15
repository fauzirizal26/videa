//
//  unlockedContentVC.swift
//  vlidea
//
//  Created by Fauzi Rizal on 14/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit

class UnlockedContentVC: UIViewController {
    
    //outlets
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var isiContentTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // navBar configuration
        navBar.isTranslucent = false
        navBar.setBackgroundImage(#imageLiteral(resourceName: "navBar"), for: .default)
        navBar.shadowImage = UIImage()
        
        // register custom table view
        isiContentTableView.register(UINib(nibName: "HeaderAndThumbnailCell", bundle: nil), forCellReuseIdentifier: "HeaderAndThumbnailCellID")
        isiContentTableView.register(UINib(nibName: "StorylineCell", bundle: nil), forCellReuseIdentifier: "storylineCellID")
        isiContentTableView.register(UINib(nibName: "KeyInspirationAndButton", bundle: nil), forCellReuseIdentifier: "keyInspirationAndButtonCellID")
        
    }
    

    // MARK: - Navigation


}

extension UnlockedContentVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = isiContentTableView.dequeueReusableCell(withIdentifier: "HeaderAndThumbnailCellID", for: indexPath) as! HeaderAndThumbnailCell
            return cell
        } else if indexPath.row == 1 {
            let cell = isiContentTableView.dequeueReusableCell(withIdentifier: "storylineCellID", for: indexPath) as! StorylineCell
            return cell
        } else {
            let cell = isiContentTableView.dequeueReusableCell(withIdentifier: "keyInspirationAndButtonCellID", for: indexPath) as! KeyInspirationAndButton
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 2 ? 500 : 600
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }

}
