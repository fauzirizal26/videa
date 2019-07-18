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
    @IBOutlet weak var isiContentTableView: UITableView!
    
    var judul = ""
    var onePhrase = ""
    var collabWith = ""
    var settings = ""
    var unique = ""
    var booming = ""
    var savedVideoURL = ""
    var savedThumbnail: UIImage = UIImage()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            cell.lockedUnlockedLabel.text = "Telah Terbuka"
            cell.thumbnailPicture.image = savedThumbnail
            cell.titleLabel.text = judul
            return cell
        } else if indexPath.row == 1 {
            let cell = isiContentTableView.dequeueReusableCell(withIdentifier: "storylineCellID", for: indexPath) as! StorylineCell
            return cell
        } else {
            let cell = isiContentTableView.dequeueReusableCell(withIdentifier: "keyInspirationAndButtonCellID", for: indexPath) as! KeyInspirationAndButton
            cell.judulLabel.text = judul
            cell.onePhraseLabel.text = onePhrase
            cell.collabWithLabel.text = collabWith
            cell.settingsLabel.text = settings
            cell.uniqueLabel.text = unique
            cell.boomingFactorLabel.text = booming
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
