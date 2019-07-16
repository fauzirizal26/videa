//
//  SetLockedTimerVC.swift
//  vlidea
//
//  Created by Fauzi Rizal on 13/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit
import CoreData

class SetLockedTimerVC: UIViewController{
    
    // outlets
    @IBOutlet weak var dayNumPicker: UIPickerView!
    @IBOutlet weak var dayStringPicker: UIPickerView!
    @IBOutlet weak var hourNumPicker: UIPickerView!
    @IBOutlet weak var hourStringPicker: UIPickerView!
    
    // variables
    let datePickerData = DatePickerModel()
    var judul = ""
    var onePhrase = ""
    var collabWith = ""
    var settings = ""
    var unique = ""
    var booming = ""
    var savedVideoURL = ""
    

    
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
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // set as delegate and data source
        
        // start picker view from day one
        dayNumPicker.selectRow(1, inComponent: 0, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Navigation
    @IBAction func closeButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Yakin mau keluar?", message: "Kalau kamu keluar, semua progress tidak akan terekam", preferredStyle: .alert)
        
        let keluar = UIAlertAction(title: "Keluar", style: .default) { (keluar) in
            
            self.performSegue(withIdentifier: "goBackHomeToIdeku", sender: self)
        }
        let batal = UIAlertAction(title: "Batal", style: .cancel, handler: nil)
        
        alert.addAction(batal)
        alert.addAction(keluar)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func kunciButton(_ sender: UIButton) {
        let simpanData = Konten(context: self.context)
        simpanData.judul = judul
        simpanData.onePhrase = onePhrase
        simpanData.collabWith = collabWith
        simpanData.setting = settings
        simpanData.uniqueFactor = unique
        simpanData.boomingFactor = booming
        simpanData.savedVideo = savedVideoURL

        dataKonten.append(simpanData)
        saveData()
        
        self.performSegue(withIdentifier: "goBackHomeToIdeku", sender: self)
    }
 

}


extension SetLockedTimerVC: UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - Picker view data source and delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == dayNumPicker {
            return datePickerData.numberOfDaysArray.count
        } else if pickerView == dayStringPicker {
            return datePickerData.daysArray.count
        } else if pickerView == hourNumPicker {
            return datePickerData.numberOfHourArray.count
        } else if pickerView == hourStringPicker {
            return datePickerData.HourArray.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView == dayNumPicker {
            return datePickerData.numberOfDaysArray[row]
        } else if pickerView == dayStringPicker {
            return datePickerData.daysArray[row]
        } else if pickerView == hourNumPicker {
            return datePickerData.numberOfHourArray[row]
        } else if pickerView == hourStringPicker {
            return datePickerData.HourArray[row]
        } else {
            return ""
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == dayNumPicker {
            if row > 0 {
                hourNumPicker.isHidden = true
                hourStringPicker.isHidden = true
            } else {
                hourNumPicker.isHidden = false
                hourStringPicker.isHidden = false
            }
        }
    }
    
}
