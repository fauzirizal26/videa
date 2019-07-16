//
//  IdekuCVC.swift
//  vlidea
//
//  Created by Fauzi Rizal on 09/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class IdekuCVC: UIViewController {
    
    // outlets
    @IBOutlet weak var collectionContent: UICollectionView!
    
    // variables
    let backgroundImageController = UIImage(named: "navBar")
    let testArray = ["a", "b", "c", "d", "e"]
    var dataKonten: [NSManagedObject] = []
    
    // MARK: - View
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // navigation
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.setBackgroundImage(backgroundImageController, for: .default)
        navigationController?.navigationBar.isTranslucent = false
        
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
        collectionContent.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionContent.register(UINib(nibName: "ContentCollectionCell", bundle: nil), forCellWithReuseIdentifier: "contentCellID")
        collectionContent.delegate = self
        collectionContent.dataSource = self
        
    }


    // MARK: - Navigation
     
     @IBAction func bikinIdeButton(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "goToBikinIde", sender: self)
     }
     

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - Fetching data from Core Data
    
    func loadData() {
        let request: NSFetchRequest = Konten.fetchRequest()
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
            cell.lockedUnlockedLabel.text = "Terbuka"
            cell.titleLabel.text = dataKonten[indexPath.row].value(forKey: "judul") as? String
            cell.thumbnailPicture.image = #imageLiteral(resourceName: "DSC_0093")
            return cell
        }
        
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "lockedContentSegue", sender: self)
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
}
