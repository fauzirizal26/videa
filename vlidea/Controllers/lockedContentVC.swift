//
//  lockedContentVCViewController.swift
//  vlidea
//
//  Created by Fauzi Rizal on 11/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit

class lockedContentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // back button navBar
        let backButtonBar = UIBarButtonItem(image: UIImage(named: "Chevron"), style: .plain, target: navigationController, action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButtonBar
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
