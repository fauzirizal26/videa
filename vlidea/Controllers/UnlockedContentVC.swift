//
//  unlockedContentVC.swift
//  vlidea
//
//  Created by Fauzi Rizal on 14/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import CoreData

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
    var doneStroryboard = false
    var nillChecker = true
    var dataKonten: [Konten] = [Konten]()
    
    var alurCeritaTextView = ""
    var klimaksTextView = ""
    var pembukaanDanPenutupanTextView = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register custom table view
        isiContentTableView.register(UINib(nibName: "HeaderAndThumbnailCell", bundle: nil), forCellReuseIdentifier: "HeaderAndThumbnailCellID")
        isiContentTableView.register(UINib(nibName: "StorylineCell", bundle: nil), forCellReuseIdentifier: "storylineCellID")
        isiContentTableView.register(UINib(nibName: "KeyInspirationAndButton", bundle: nil), forCellReuseIdentifier: "keyInspirationAndButtonCellID")
        isiContentTableView.register(UINib(nibName: "PertanyaanCell", bundle: nil), forCellReuseIdentifier: "pertanyaanCellID")
        
        
        retrieveData()
    }
    

    // play button
    @objc func playButtonPressed() {
        let video = AVPlayer(url: URL(fileURLWithPath: savedVideoURL))
        let videoPlayer = AVPlayerViewController()
        videoPlayer.player = video

        present(videoPlayer, animated: true) {
            print(self.savedVideoURL)
            video.play()
        }
    }
    
    // MARK: - Core Data
    let managedContext = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
    
    func retrieveData() {
        let request: NSFetchRequest = Konten.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            dataKonten = try managedContext.fetch(request)
            print(" data konten bro \(dataKonten[dataKonten.count-1])")
            if dataKonten[dataKonten.count-1].alurCeritaTextView == nil {
                nillChecker = true
            } else {
                nillChecker = false
            }
        } catch {
            print(error)
        }
    }

    @objc func tambahTextViewKeCoreData() {
        
        let request: NSFetchRequest = Konten.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            
            dataKonten[dataKonten.count-1].setValue(alurCeritaTextView, forKey: "alurCeritaTextView")
            dataKonten[dataKonten.count-1].setValue(pembukaanDanPenutupanTextView, forKey: "pembukaanDanPenutupanTextView")
            dataKonten[dataKonten.count-1].setValue(klimaksTextView, forKey: "klimaksTextView")
            do {
                try managedContext.save()
                self.navigationController?.popToRootViewController(animated: true)
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }

}

extension UnlockedContentVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if nillChecker {
            if indexPath.row == 0 {
                let cell = isiContentTableView.dequeueReusableCell(withIdentifier: "keyInspirationAndButtonCellID", for: indexPath) as! KeyInspirationAndButton
                cell.judulLabel.text = judul
                cell.onePhraseLabel.text = onePhrase
                cell.collabWithLabel.text = collabWith
                cell.settingsLabel.text = settings
                cell.uniqueLabel.text = unique
                cell.boomingFactorLabel.text = booming
                isiContentTableView.rowHeight = 414
                return cell
                
            } else {
                let cell = isiContentTableView.dequeueReusableCell(withIdentifier: "pertanyaanCellID", for: indexPath) as! PertanyaanCell
                isiContentTableView.rowHeight = 1100
                klimaksTextView = cell.klimaksTextView.text
                alurCeritaTextView = cell.alurCeritaTextView.text
                pembukaanDanPenutupanTextView = cell.pembukaanDanPenutupanTextView.text
                cell.selesaiButton.addTarget(self, action: #selector(tambahTextViewKeCoreData), for: .touchUpInside)
                return cell
            }
        } else {
            if indexPath.row == 0 {
                let cell = isiContentTableView.dequeueReusableCell(withIdentifier: "HeaderAndThumbnailCellID", for: indexPath) as! HeaderAndThumbnailCell
                cell.lockedUnlockedLabel.text = "Telah Terbuka"
                cell.thumbnailPicture.image = savedThumbnail
                cell.titleLabel.text = judul
                cell.playButtonLabel.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
                isiContentTableView.rowHeight = 515
                return cell
            } else if indexPath.row == 1 {
                let cell = isiContentTableView.dequeueReusableCell(withIdentifier: "storylineCellID", for: indexPath) as! StorylineCell
                isiContentTableView.rowHeight = 1000
                 
                return cell
            } else  {
                let cell = isiContentTableView.dequeueReusableCell(withIdentifier: "keyInspirationAndButtonCellID", for: indexPath) as! KeyInspirationAndButton
                cell.judulLabel.text = judul
                cell.onePhraseLabel.text = onePhrase
                cell.collabWithLabel.text = collabWith
                cell.settingsLabel.text = settings
                cell.uniqueLabel.text = unique
                cell.boomingFactorLabel.text = booming
                isiContentTableView.rowHeight = 414
                
                return cell
            }
        }
    }
}
