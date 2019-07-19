//
//  TutorialVC.swift
//  vlidea
//
//  Created by Fauzi Rizal on 18/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit

class TutorialVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tipsButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToTips", sender: self)
    }
    
    @IBAction func panduanLanjutanButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToPanduan", sender: self)
    }
    
    @IBAction func tentangKamiButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToTentangKami", sender: self)
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