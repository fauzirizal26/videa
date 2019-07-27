//
//  IdekuCVC.swift
//  vlidea
//
//  Created by Fauzi Rizal on 09/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation


class IdekuCVC: UIViewController {
    
    // outlets
    //@IBOutlet weak var collectionContent: UICollectionView!
    @IBOutlet weak var tableContent: UITableView!
    
    
    // variables
    var dataKonten: [NSManagedObject] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var refreshControl = UIRefreshControl()
    var index = 0
    
    // time related variables
    var currentTime = Date()
    
    
    // didSelect container variables
    var judul = ""
    var onePhrase = ""
    var collabWith = ""
    var settings = ""
    var unique = ""
    var booming = ""
    var savedVideoURL = ""
    var savedThumbnail: UIImage = UIImage()

  
    // MARK: - View
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // navigation
        self.buttonKananPlus()
        // core data
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Konten")
        
        do {
            dataKonten = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        // collection view
        dataKonten.reverse()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        tableContent.register(UINib(nibName: "HeaderAndThumbnailCell", bundle: nil), forCellReuseIdentifier: "HeaderAndThumbnailCellID")
        
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        //collectionContent.addSubview(refreshControl)
        tableContent.addSubview(refreshControl)
        
        print(currentTime)
        
    }
    
    // MArk: - Refresh
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        tableContent.reloadData()
        refreshControl.endRefreshing()
        currentTime = Date()
        print(currentTime)
    }
    
    // MARK: - Thumbnail Video
    func videoPreviewUIImage(moviePath: String) -> UIImage? {
        let asset = AVURLAsset(url: URL(string: moviePath)!)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        let timestamp = CMTime(seconds: 2, preferredTimescale: 60)
        if let imageRef = try? generator.copyCGImage(at: timestamp, actualTime: nil) {
            return UIImage(cgImage: imageRef)
        } else {
            return nil
        }
    }
    
    // MARK: - Fetching data from Core Data
    
    func loadData() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Konten")
        
        
        do {
            dataKonten = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Navigations
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lockedContentSegue" {
            let nextVC = segue.destination as! LockedContentVC
            nextVC.judul = judul
            nextVC.onePhrase = onePhrase
            nextVC.collabWith = collabWith
            nextVC.settings = settings
            nextVC.unique = unique
            nextVC.booming = booming
            nextVC.savedThumbnail = savedThumbnail
            
        } else if segue.identifier == "unlockedContentSegue" {
            let nextVC = segue.destination as! UnlockedContentVC
            nextVC.judul = judul
            nextVC.onePhrase = onePhrase
            nextVC.collabWith = collabWith
            nextVC.settings = settings
            nextVC.unique = unique
            nextVC.booming = booming
            nextVC.savedThumbnail = savedThumbnail
            nextVC.index = index
        }
    }

}

extension IdekuCVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataKonten.count < 1 {
            return 1
        } else {
            return dataKonten.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableContent.dequeueReusableCell(withIdentifier: "HeaderAndThumbnailCellID", for: indexPath) as! HeaderAndThumbnailCell
        
        if indexPath.row == dataKonten.count {
            
            cell.lockedUnlockedLabel.text = "Terbuka"
            cell.titleLabel.text = "Tutorial Vide"
            cell.thumbnailPicture.image = #imageLiteral(resourceName: "testerThumbnail")
            cell.playButtonLabel.isHidden = true
            cell.thumbnailPicture.contentMode = UIView.ContentMode.scaleAspectFit
            
            return cell
        } else {
            if currentTime >= dataKonten[indexPath.row].value(forKey: "pickedDateToLockContent") as! Date {
                cell.lockedUnlockedLabel.text = "Terbuka"
                cell.titleLabel.text = dataKonten[indexPath.row].value(forKey: "judul") as? String
                let fetchedData = dataKonten[indexPath.row]
                let theURL = fetchedData.value(forKey: "savedVideo") as? String
                cell.thumbnailPicture.image = videoPreviewUIImage(moviePath: theURL!)
                cell.thumbnailPicture.contentMode = UIView.ContentMode.scaleAspectFit
                cell.playButtonLabel.isHidden = true
                
                return cell
            } else {
                cell.lockedUnlockedLabel.text = "Tertutup"
                cell.titleLabel.text = dataKonten[indexPath.row].value(forKey: "judul") as? String
                let fetchedData = dataKonten[indexPath.row]
                let theURL = fetchedData.value(forKey: "savedVideo") as? String
                cell.thumbnailPicture.image = videoPreviewUIImage(moviePath: theURL!)
                cell.thumbnailPicture.contentMode = UIView.ContentMode.scaleAspectFit
                cell.playButtonLabel.isHidden = true
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == dataKonten.count {
            performSegue(withIdentifier: "goToTutorialSegue", sender: self)
        } else {
            if currentTime >= dataKonten[indexPath.row].value(forKey: "pickedDateToLockContent") as! Date {
                judul = dataKonten[indexPath.row].value(forKey: "judul") as! String
                onePhrase = dataKonten[indexPath.row].value(forKey: "onePhrase") as! String
                collabWith = dataKonten[indexPath.row].value(forKey: "collabWith") as! String
                settings = dataKonten[indexPath.row].value(forKey: "setting") as! String
                unique = dataKonten[indexPath.row].value(forKey: "uniqueFactor") as! String
                booming = dataKonten[indexPath.row].value(forKey: "boomingFactor") as! String
                savedVideoURL = dataKonten[indexPath.row].value(forKey: "savedVideo") as! String
                
                
                
                let fetchedData = dataKonten[indexPath.row]
                let theURL = fetchedData.value(forKey: "savedVideo") as? String
                savedThumbnail = videoPreviewUIImage(moviePath: theURL!)!
                index = indexPath.row
                performSegue(withIdentifier: "unlockedContentSegue", sender: self)
            } else {
                judul = dataKonten[indexPath.row].value(forKey: "judul") as! String
                onePhrase = dataKonten[indexPath.row].value(forKey: "onePhrase") as! String
                collabWith = dataKonten[indexPath.row].value(forKey: "collabWith") as! String
                settings = dataKonten[indexPath.row].value(forKey: "setting") as! String
                unique = dataKonten[indexPath.row].value(forKey: "uniqueFactor") as! String
                booming = dataKonten[indexPath.row].value(forKey: "boomingFactor") as! String
                savedVideoURL = dataKonten[indexPath.row].value(forKey: "savedVideo") as! String
                
                let fetchedData = dataKonten[indexPath.row]
                let theURL = fetchedData.value(forKey: "savedVideo") as? String
                savedThumbnail = videoPreviewUIImage(moviePath: theURL!)!
                
                
                performSegue(withIdentifier: "lockedContentSegue", sender: self)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            dataKonten.remove(at: indexPath.row)
            tableContent.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 514
    }
}
