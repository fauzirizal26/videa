//
//  BukaKunciVC.swift
//  vlidea
//
//  Created by Aditya Patriazka on 16/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit

class BukaKunciVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textBuka: TextFieldStyle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textBuka.delegate = self
        // Do any additional setup after loading the view.
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
