//
//  ViewController.swift
//  Deal
//
//  Created by Ki Suk Jang on 4/23/15.
//  Copyright (c) 2015 Ki Suk Jang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var my_icon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Round my_icon
        my_icon.layer.cornerRadius = my_icon.frame.size.height / 2;
        my_icon.clipsToBounds = true
        my_icon.layer.borderWidth = 0.5
        my_icon.layer.borderColor = UIColor.blackColor().CGColor
        
        // Add motion effect on my_icon
        my_icon.addMotionEffect(getMotionEffectGroup())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getMotionEffectGroup () ->UIMotionEffect {
        print ("ddddddd\n")
        // Set vertical effect
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
            type: .TiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -10
        verticalMotionEffect.maximumRelativeValue = 10
        
        // Set horizontal effect
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
            type: .TiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -10
        horizontalMotionEffect.maximumRelativeValue = 10
        
        // Create group to combine both
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        
        return group
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }

}

