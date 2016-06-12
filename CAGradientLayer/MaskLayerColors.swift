//
//  MaskLayerColors.swift
//  CAGradientLayer
//
//  Created by yaosixu on 16/6/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

@IBDesignable
class MaskLayer : UIView {
    let maskLayer = CALayer()
    
    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        
        // Configure the gradient here
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let colors = [
            UIColor.yellowColor().CGColor,
            UIColor.greenColor().CGColor,
            UIColor.orangeColor().CGColor,
            UIColor.cyanColor().CGColor,
            UIColor.redColor().CGColor,
            UIColor.yellowColor().CGColor
        ]
        gradientLayer.colors = colors

        //颜色分割线
        let locations = [
            0.0, 0.0, 0.0, 0.0, 0.0, 0.25
        ]
        gradientLayer.locations = locations
        
        return gradientLayer
    }()

    let textAttribute : [String: AnyObject] = {
        let style = NSMutableParagraphStyle()
        style.alignment = .Center
        
        return [NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 28.0)!,
                NSParagraphStyleAttributeName:style]
    }()

    @IBInspectable var text : String! {
        didSet{
            setNeedsDisplay()
            
            UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
            text.drawInRect(bounds, withAttributes: textAttribute)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            maskLayer.backgroundColor = UIColor.clearColor().CGColor
            maskLayer.frame = layer.bounds
            maskLayer.contents = image.CGImage
//            gradientLayer.mask = maskLayer
        }
    }
    
//    override func layoutSubviews() {
//        gradientLayer.frame = CGRect(x: -bounds.size.width, y: bounds.origin.y, width: 3 * bounds.size.width, height: bounds.size.height)
//        print("layer.frame = \(layer.frame)")
//    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        gradientLayer.frame = CGRect(x: -100, y: bounds.origin.y, width: UIScreen.mainScreen().bounds.width, height: bounds.size.height)
        print("layer.frame = \(layer.frame)")
//        gradientLayer.borderWidth = 3.0
//        gradientLayer.borderColor = UIColor.whiteColor().CGColor
        
        gradientLayer.mask = maskLayer
        
        layer.addSublayer(gradientLayer)
        
        let animated = CABasicAnimation(keyPath: "locations")
        animated.fromValue = [0.0,0.0,0.0,0.0,0.0,0.25]
        animated.toValue = [0.6,0.65,0.8,0.85,0.9,1.0]
        animated.duration = 3.0
        animated.repeatCount = Float.infinity
        
        gradientLayer.addAnimation(animated, forKey: nil)
    }
    
}