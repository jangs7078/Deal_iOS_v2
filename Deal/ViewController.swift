//
//  ViewController.swift
//  Deal
//
//  Created by Ki Suk Jang on 4/23/15.
//  Copyright (c) 2015 Ki Suk Jang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var my_icon: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Configure my icon
        configureMyIcon()
        
        // Get Contact List
        AddrBookService().requestAccess()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureMyIcon() {
        // Round my_icon
        my_icon.layer.cornerRadius = my_icon.frame.size.height / 2;
        my_icon.clipsToBounds = true
        my_icon.layer.borderWidth = 1.0
        my_icon.layer.borderColor = UIColor.whiteColor().CGColor
        
        // Add motion effect on my_icon
        my_icon.addMotionEffect(getMotionEffectGroup())
    }

    func getMotionEffectGroup () ->UIMotionEffectGroup {
        // Set vertical effect
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
            type: .TiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -200
        verticalMotionEffect.maximumRelativeValue = 200
        
        // Set horizontal effect
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
            type: .TiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -200
        horizontalMotionEffect.maximumRelativeValue = 200
        
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

