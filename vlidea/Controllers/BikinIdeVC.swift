//
//  BikinIdeVC.swift
//  vlidea
//
//  Created by Fauzi Rizal on 08/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit

class BikinIdeVC: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    // outlets
    @IBOutlet weak var ideTextField: TextFieldStyle!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // navBar configuration
        self.closeButtonKanan()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(recognizer:)))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
        
        
        // keyboard
        ideTextField.becomeFirstResponder()
    }
    
    
    
    // MARK: - Navigation
    
    
    @objc func viewTapped(recognizer: UITapGestureRecognizer) {
        ideTextField.endEditing(true)
    }
    
    @IBAction func cariInspirasiButton(_ sender: UIButton) {
        
        if  ideTextField.text != "" {
            performSegue(withIdentifier: "goToBrainstorm", sender: self)
        } else if ideTextField.text == "" {
            
            let alert = UIAlertController(title: "Kosong", message: "ide tidak bisa kosong", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Baik", style: .default, handler: nil)
            
            self.present(alert, animated: true, completion: nil)
            alert.addAction(action)
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextVC = segue.destination as! BrainstormVC
        nextVC.judulBaru = ideTextField.text!
        nextVC.navigationItem.hidesBackButton = true
    }
    
    
    // MARK: - Keyboard stuff
    
    func hideKeyboard() {
        ideTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
}


