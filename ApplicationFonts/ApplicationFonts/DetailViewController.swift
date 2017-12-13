//
//  DetailViewController.swift
//  ApplicationFonts
//
//  Created by LETUE Erwann on 13/12/2017.
//  Copyright © 2017 Gobelins. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    var fontName: String?
    
    override func viewWillAppear(_ animated: Bool) {
        if let fontName = fontName {
            textView.font = UIFont.init(name: fontName, size: 24)
            title = fontName
        }
    }
}
