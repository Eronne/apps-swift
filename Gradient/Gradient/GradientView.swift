//
//  GradientView.swift
//  Gradient
//
//  Created by LETUE Erwann on 13/12/2017.
//  Copyright © 2017 Gobelins. All rights reserved.
//

import UIKit

class Gradient: NSObject {
    var topColor: UIColor?
    var bottomColor: UIColor?
    var colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
    
    func draw(_ rect: CGRect, context: CGContext) {
        if let topColor = topColor {
            if let bottomColor = bottomColor {
                let colorsArray = [topColor.cgColor, bottomColor.cgColor]
                let gradient = CGGradient(colorsSpace: colorSpace, colors: colorsArray as CFArray, locations: nil)
                context.addRect(rect)
                context.drawLinearGradient(gradient!, start: CGPoint(x:0, y:0), end: CGPoint(x:0, y:rect.size.height), options: .drawsAfterEndLocation)
            }
        }
    }
}

@IBDesignable class GradientView: UIView {
    
    @IBInspectable var topColor: UIColor!
    @IBInspectable var bottomColor: UIColor!

    override func draw(_ rect: CGRect) {
        let gradient = Gradient()
        gradient.topColor = topColor
        gradient.bottomColor = bottomColor
        gradient.draw(rect, context: UIGraphicsGetCurrentContext()!)
    }
}
