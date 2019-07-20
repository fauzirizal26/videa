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

private let reuseIdentifier = "Cell"



class IdekuCVC: UIViewController {
    
    // outlets
    @IBOutlet weak var collectionContent: UICollectionView!
    
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
        collectionContent.register(UINib(nibName: "ContentCollectionCell", bundle: nil), forCellWithReuseIdentifier: "contentCellID")
        
        
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        collectionContent.addSubview(refreshControl)
        
        print(currentTime)
        
    }
    
    // MArk: - Refresh
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        collectionContent.reloadData()
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
        } else if segue.identifier == "goToBikinIdeVC" {
            let nextVC = segue.destination as! UINavigationController
            let next2VC = nextVC.topViewController as! BikinIdeVC
            
        }
    }

}

extension IdekuCVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if dataKonten.count < 1 {
            return 1
        } else {
            return dataKonten.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contentCellID", for: indexPath) as! ContentCollectionCell
        
        if indexPath.row == dataKonten.count {
            
            cell.lockedUnlockedLabel.text = "Terbuka"
            cell.titleLabel.text = "My First Vlog"
            cell.thumbnailPicture.image = #imageLiteral(resourceName: "testerThumbnail")
            
            return cell
        } else {
            if currentTime >= dataKonten[indexPath.row].value(forKey: "pickedDateToLockContent") as! Date {
                cell.lockedUnlockedLabel.text = "Terbuka"
                cell.titleLabel.text = dataKonten[indexPath.row].value(forKey: "judul") as? String
                let fetchedData = dataKonten[indexPath.row]
                let theURL = fetchedData.value(forKey: "savedVideo") as? String
                cell.thumbnailPicture.image = videoPreviewUIImage(moviePath: theURL!)

                return cell
            } else {
                cell.lockedUnlockedLabel.text = "Tertutup"
                cell.titleLabel.text = dataKonten[indexPath.row].value(forKey: "judul") as? String
                let fetchedData = dataKonten[indexPath.row]
                let theURL = fetchedData.value(forKey: "savedVideo") as? String
                cell.thumbnailPicture.image = videoPreviewUIImage(moviePath: theURL!)
                return cell
            }
        }
        
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
    
    
    }
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    // MARK: - cell design
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        return CGSize(width: 375, height: 455)
//    }
