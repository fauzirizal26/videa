//
//  BrainstormVC.swift
//  vlidea
//
//  Created by Fauzi Rizal on 08/07/19.
//  Copyright © 2019 Fauzi Rizal. All rights reserved.
//

import UIKit

class BrainstormVC: UIViewController {
    
    // outlets content
    @IBOutlet weak var judulLabel: UILabel!
    @IBOutlet weak var onePhraseLabel: UILabel!
    @IBOutlet weak var collabWithLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var uniqueFactorsLabel: UILabel!
    @IBOutlet weak var boomingFactorsLabel: UILabel!
    @IBOutlet weak var keyInspirationLabel: UILabel!
    @IBOutlet weak var kontenSV: UIStackView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    

    // outlets button animated
    @IBOutlet weak var lanjutOutlet: UIButton!
    @IBOutlet weak var textOnePopped: UILabel!
    @IBOutlet weak var textTwoPopped: UILabel!
    @IBOutlet weak var backToBikinIdeOutlet: UIBarButtonItem!
    @IBOutlet weak var inspirasiLainOutlet: UIButton!
    
    
    
    // variables
    let inspirasiData = DataInspirasiClass()

    // dari VC sebelah
    var judulBaru = ""
    
    // bikin bulet progress bar
    let shapeLayer = CAShapeLayer()
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hidden texts
        textOnePopped.frame = CGRect(x: 500, y: 74, width: 354, height: 120)
        textTwoPopped.frame = CGRect(x: 500, y: 74, width: 354, height: 120)
        

        
        // isi konten
        judulLabel.text = judulBaru
        onePhraseLabel.text = inspirasiData.onePhraseArray[Int.random(in: 0...inspirasiData.onePhraseArray.count - 1)][Int.random(in: 0...2)]
        collabWithLabel.text = inspirasiData.collabWithArray[Int.random(in: 0...inspirasiData.collabWithArray.count - 1)]
        settingsLabel.text = inspirasiData.settingsArray[Int.random(in: 0...2)][Int.random(in: 0...3)]
        uniqueFactorsLabel.text = inspirasiData.uniqueFactorArray[Int.random(in: 0...2)]
        boomingFactorsLabel.text = inspirasiData.boomingFactorArray[Int.random(in: 0...inspirasiData.boomingFactorArray.count - 1)]
        
    }
    
    //MARK: - ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backgroundImageController = UIImage(named: "navBar")
        navBar.setBackgroundImage(backgroundImageController, for: .default)
        navBar.isTranslucent = false
        navBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        backToBikinIdeOutlet.isEnabled = true
    }
    
    
    
    // MARK: - Navigation
    
    
    @IBAction func backToBikinIdeButton(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    // reshuffle
    @IBAction func inspirasiLain(_ sender: UIButton) {
        let categoryRandomizer = Int.random(in: 0...2)
        let onePhraseRandomizer = Int.random(in: 0...inspirasiData.onePhraseArray[categoryRandomizer].count - 1)
        let collabWithRandomizer = Int.random(in: 0...inspirasiData.collabWithArray.count - 1)
        let settingsRandomizer = Int.random(in: 0...inspirasiData.settingsArray[categoryRandomizer].count - 1)
        let uniqueFactorRandomizer = Int.random(in: 0...inspirasiData.uniqueFactorArray.count - 1)
        let boomingFactorRandomizer = Int.random(in: 0...inspirasiData.boomingFactorArray.count - 1)
        
        onePhraseLabel.text = inspirasiData.onePhraseArray[categoryRandomizer][onePhraseRandomizer]
        collabWithLabel.text = inspirasiData.collabWithArray[collabWithRandomizer]
        settingsLabel.text = inspirasiData.settingsArray[categoryRandomizer][settingsRandomizer]
        uniqueFactorsLabel.text = inspirasiData.uniqueFactorArray[uniqueFactorRandomizer]
        boomingFactorsLabel.text = inspirasiData.boomingFactorArray[boomingFactorRandomizer]
    }
    
    
    // accepted
    @IBAction func lanjutButton(_ sender: UIButton) {
        
        self.progressBarAnimation()
        self.animationOne()
        let timer = Timer.scheduledTimer(timeInterval: 23, target: self, selector: #selector(animationTwo), userInfo: nil, repeats: false)
        timer.fireDate.addTimeInterval(0)
        let timerSegue = Timer.scheduledTimer(timeInterval: 48, target: self, selector: #selector(segueTime), userInfo: nil, repeats: false)
        timerSegue.fireDate.addTimeInterval(0)

        
    }
    
    // MARK: - ANIMATION STUFF
    func animationOne() {
        UIView.animate(withDuration: 1.5) {
            self.backToBikinIdeOutlet.isEnabled = false
            self.inspirasiLainOutlet.frame.origin.y = 1000
            self.lanjutOutlet.frame.origin.y = 1000
            self.keyInspirationLabel.frame.origin.x = -500
            self.textOnePopped.frame.origin.x = 30
        }
    }
    
    @objc func animationTwo() {
        UIView.animate(withDuration: 1.5, animations: {
            self.textOnePopped.frame.origin.x = -500
            self.textTwoPopped.frame.origin.x = 30
        }, completion: nil)
    }
    
    @objc func segueTime() {
        performSegue(withIdentifier: "goToVideo", sender: self)
    }
    
    func progressBarAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: 207, y: 740), radius: 50, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
    
        // moving shape
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.4881275892, green: 0.06164245307, blue: 0.2529866993, alpha: 1)
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(shapeLayer)
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 60
        basicAnimation.isRemovedOnCompletion = false
        
        self.shapeLayer.add(basicAnimation, forKey: "strokeEnd")
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let goToBrainstormVC = segue.destination as! CameraVC
        goToBrainstormVC.judul = judulBaru
        goToBrainstormVC.onePhrase = onePhraseLabel.text!
        goToBrainstormVC.collabWith = collabWithLabel.text!
        goToBrainstormVC.settings = settingsLabel.text!
        goToBrainstormVC.unique = uniqueFactorsLabel.text!
        goToBrainstormVC.booming = boomingFactorsLabel.text!
        
    }

}

