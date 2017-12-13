//
//  ViewController.swift
//  Application
//
//  Created by LETUE Erwann on 11/12/2017.
//  Copyright © 2017 Gobelins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var visibilitySwitch: UISwitch!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageSelector: UISegmentedControl!
    @IBOutlet weak var opacitySlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleLanguage(_ sender: UIButton) {
        if (label.text == "Application Label") {
            label.text = "Label de l'application"
        } else {
            label.text = "Aplication Label"
        }
    }
    
    
    @IBAction func toggleSwitch(_ sender: UISwitch) {
        label.isHidden = !label.isHidden
    }

    @IBAction func changeImage(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            imageView.image = UIImage(named: "arcenciel")
        case 1:
            imageView.image = UIImage(named: "mousse")
        case 2:
            imageView.image = UIImage(named: "pirate")
        case 3:
            imageView.image = UIImage(named: "plage")
        case 4:
            imageView.image = UIImage(named: "sable")
        default:
            imageView.image = UIImage(named: "arcenciel")
        }
    }
    
    @IBAction func changeOpacity(_ sender: UISlider) {
        imageView.alpha = CGFloat(sender.value)
    }
    
}

