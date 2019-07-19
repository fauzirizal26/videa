//
//  lockedContentVCViewController.swift
//  vlidea
//
//  Created by Fauzi Rizal on 11/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit

class LockedContentVC: UIViewController {
    
    // outlets
    @IBOutlet weak var judulLabel: UILabel!
    @IBOutlet weak var onePhraseLabel: UILabel!
    @IBOutlet weak var collabWithLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var uniqueLabel: UILabel!
    @IBOutlet weak var boomingLabel: UILabel!
    @IBOutlet weak var thumbnailPicture: UIImageView!
    @IBOutlet weak var lockedUnlockedLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // variables from saved core data
    var judul = ""
    var onePhrase = ""
    var collabWith = ""
    var settings = ""
    var unique = ""
    var booming = ""
    var savedVideoURL = ""
    var savedThumbnail: UIImage = UIImage()
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
        
        print(index)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func updateUI() {
        judulLabel.text = judul
        onePhraseLabel.text = onePhrase
        collabWithLabel.text = collabWith
        settingsLabel.text = settings
        uniqueLabel.text = unique
        boomingLabel.text = booming
        thumbnailPicture.image = savedThumbnail
        titleLabel.text = judul
        thumbnailPicture.image = savedThumbnail
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToBukaKunciSegue" {
//            let nextVC = segue.destination as! BukaKunciVC
//            nextVC.judul = judul
//            nextVC.onePhrase = onePhrase
//            nextVC.collabWith = collabWith
//            nextVC.settings = settings
//            nextVC.unique = unique
//            nextVC.booming = booming
//        }
//
//    }

}
