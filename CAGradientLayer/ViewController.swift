//
//  ViewController.swift
//  CAGradientLayer
//
//  Created by yaosixu on 16/6/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var maskLayer: MaskLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGrayColor()
        automaticallyAdjustsScrollViewInsets = false
        
        maskLayer.text = "Slide to reveal "
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    

}

