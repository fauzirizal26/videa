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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Yakin mau ulang?", message: "Video mu tadi akan hilang", preferredStyle: .alert)
        
        let ulang = UIAlertAction(title: "Ulang", style: .default) { (keluar) in
            
            self.dismiss(animated: true, completion: nil)
        }
        
        let batal = UIAlertAction(title: "Batal", style: .cancel, handler: nil)
        
        alert.addAction(batal)
        alert.addAction(ulang)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func lanjutButton(_ sender: UIButton) {
        performSegue(withIdentifier: "lanjutSegue", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lanjutSegue" {
            let nextVC = segue.destination as! SetLockedTimerVC
            nextVC.judul = judul
            nextVC.onePhrase = onePhrase
            nextVC.collabWith = collabWith
            nextVC.settings = settings
            nextVC.unique = unique
            nextVC.booming = booming
            nextVC.savedVideoURL = savedVideoURL
        }
    }
   
}
