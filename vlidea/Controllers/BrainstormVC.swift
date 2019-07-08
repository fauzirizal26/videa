//
//  BrainstormVC.swift
//  vlidea
//
//  Created by Fauzi Rizal on 08/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit

class BrainstormVC: UIViewController {
    
    // outlets
    @IBOutlet weak var reshuffleOutlet: UIButton!
    @IBOutlet weak var acceptOutlet: UIButton!
    @IBOutlet weak var progressBarrOutlet: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressBarrOutlet.frame.origin.y = 1000
        
    }
    
    @IBAction func acceptButtonDidTap(_ sender: Any) {
        
        UIView.animate(withDuration: 2) {
            self.reshuffleOutlet.frame.origin.y = 1000
            //self.reshuffleOutlet.isHidden = true
            self.acceptOutlet.frame.origin.y = 1000
            //self.acceptOutlet.isHidden = true
            self.progressBarrOutlet.frame.origin.y = 620
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
