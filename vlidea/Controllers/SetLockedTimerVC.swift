//
//  SetLockedTimerVC.swift
//  vlidea
//
//  Created by Fauzi Rizal on 13/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit

class SetLockedTimerVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // outlets
    @IBOutlet weak var dayNumPicker: UIPickerView!
    @IBOutlet weak var dayStringPicker: UIPickerView!
    @IBOutlet weak var hourNumPicker: UIPickerView!
    @IBOutlet weak var hourStringPicker: UIPickerView!
    
    
    // variables
    var numberOfDaysArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    var numberOfHourArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
    "11", "12"]
    var HourArray = ["Hour"]
    var daysArray = ["Days"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // set as delegate and data source
        dayNumPicker.delegate = self
        dayNumPicker.dataSource = self
        dayStringPicker.delegate = self
        dayStringPicker.dataSource = self
        hourNumPicker.delegate = self
        hourNumPicker.dataSource = self
        hourStringPicker.delegate = self
        hourStringPicker.dataSource = self
        
        // start picker view from day one
        dayNumPicker.selectRow(1, inComponent: 0, animated: true)
    }
    
    
    // MARK: - Picker view data source and delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == dayNumPicker {
            return numberOfDaysArray.count
        } else if pickerView == dayStringPicker {
            return daysArray.count
        } else if pickerView == hourNumPicker {
            return numberOfHourArray.count
        } else if pickerView == hourStringPicker {
            return HourArray.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView == dayNumPicker {
            return numberOfDaysArray[row]
        } else if pickerView == dayStringPicker {
            return daysArray[row]
        } else if pickerView == hourNumPicker {
            return numberOfHourArray[row]
        } else if pickerView == hourStringPicker {
            return HourArray[row]
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
    

    // MARK: - Navigation
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Yakin mau keluar?", message: "Kalau kamu keluar, semua progress tidak akan terekam", preferredStyle: .alert)
        
        let keluar = UIAlertAction(title: "Keluar", style: .default) { (keluar) in
            
            self.performSegue(withIdentifier: "goBackHomeToIdeku", sender: self)
        }
        
        let batal = UIAlertAction(title: "Batal", style: .cancel, handler: nil)
        
        alert.addAction(batal)
        alert.addAction(keluar)
        
        present(alert, animated: true, completion: nil)
    }
    
    
 

}
