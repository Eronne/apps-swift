//
//  ViewController.swift
//  Animations
//
//  Created by LETUE Erwann on 15/12/2017.
//  Copyright © 2017 Gobelins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var animView: UIView!
    var currentColorIndex = 0
    var colors = [UIColor.gray, UIColor.blue, UIColor.cyan, UIColor.green, UIColor.magenta, UIColor.orange, UIColor.purple, UIColor.red, UIColor.yellow]

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let p = touch.location(in: view)
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.5, options: UIViewAnimationOptions(rawValue: 0), animations: {
                self.currentColorIndex = self.currentColorIndex + 1
                if self.currentColorIndex == self.colors.count {
                    self.currentColorIndex = 0
                }
                self.animView.backgroundColor = self.colors[self.currentColorIndex]
                self.animView.center = p
            }, completion: nil)
        }
    }
}

