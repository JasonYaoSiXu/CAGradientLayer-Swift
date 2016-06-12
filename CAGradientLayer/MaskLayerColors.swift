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
    
    //定义一个蒙板层
    let maskLayer = CALayer()
    
    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        
        //把gradientLayer的长和宽的最大值都看作1
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        //设置颜色
        let colors = [
            UIColor.yellowColor().CGColor,
            UIColor.greenColor().CGColor,
            UIColor.orangeColor().CGColor,
            UIColor.cyanColor().CGColor,
            UIColor.redColor().CGColor,
            UIColor.yellowColor().CGColor
        ]
        gradientLayer.colors = colors

        //颜色分割线，个人理解相当于跑步比赛时，选手的起始位置,把gradientLayer的长度看为1
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
            
            //把该uiview以及其中所显示的文字，转换为一个图片
            UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
            text.drawInRect(bounds, withAttributes: textAttribute)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            //设置蒙板层,设置蒙板后只显示原图像和蒙板相重合的区域
            maskLayer.backgroundColor = UIColor.clearColor().CGColor
            //设置蒙板的尺寸大小和该uiview一样大
            maskLayer.frame = layer.bounds
            maskLayer.contents = image.CGImage
        }
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        //蒙板应该在所加图层的中心位置,因为gradientLayer的frame的origin的x为负值所以在蒙板相对应的地方加上这个蒙板origin.x的绝对值
        gradientLayer.frame = CGRect(x: -100, y: bounds.origin.y, width: UIScreen.mainScreen().bounds.width, height: bounds.size.height)
        
        gradientLayer.mask = maskLayer
        maskLayer.position.x = 187.5      //gradientLayer.frame的position.x = 87.5
        
        print("layer.position=\(layer.position)")
        print("maskLayer.position=\(maskLayer.position)")
        
        layer.addSublayer(gradientLayer)
        
        let animated = CABasicAnimation(keyPath: "locations")
        animated.fromValue = [0.0,0.0,0.0,0.0,0.0,0.25]  //和上面的一摸一样
        animated.toValue = [0.6,0.65,0.8,0.85,0.9,1.0]
        animated.duration = 3.0
        animated.repeatCount = Float.infinity
        
        gradientLayer.addAnimation(animated, forKey: nil)
    }
    
}