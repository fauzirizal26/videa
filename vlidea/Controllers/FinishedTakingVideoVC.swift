//
//  previewVC.swift
//  vlidea
//
//  Created by Fauzi Rizal on 12/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit

class FinishedTakingVideoVC: UIViewController {
    
    // outlets
    
    // variables
    var judul = ""
    var onePhrase = ""
    var collabWith = ""
    var settings = ""
    var unique = ""
    var booming = ""
    var savedVideoURL = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func cancelButton(_ sender: UIButton) {
        
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        let simpanData = Konten(context: self.context)
        simpanData.judul = judul
        simpanData.onePhrase = onePhrase
        simpanData.collabWith = collabWith
        simpanData.setting = settings
        simpanData.uniqueFactor = unique
        simpanData.boomingFactor = booming
        
        dataKonten.append(simpanData)
        saveData()
        
        performSegue(withIdentifier: "finishedTakingVideoSegue", sender: self)
    }
    
    // MARK: - Core Data
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dataKonten = [Konten]()
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("error: \(error)")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
