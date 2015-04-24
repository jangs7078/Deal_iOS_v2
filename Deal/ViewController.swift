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
        
        // Configure AWS Dynamo DB
        configureAWS()
        
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
    
    // Adds Credential pool and connect to DynamoDB
    func configureAWS() {
        let credentialsProvider = AWSCognitoCredentialsProvider(
            regionType: AWSRegionType.USEast1, identityPoolId: "us-east-1:554fda00-ce9b-43ec-a01b-d2ee16436ded")
        
        let defaultServiceConfiguration = AWSServiceConfiguration(
            region: AWSRegionType.USEast1, credentialsProvider: credentialsProvider)
        
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = defaultServiceConfiguration
        
        /* get one example */
        let mapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        mapper.load(User.self, hashKey: "deal@stanford.edu", rangeKey: "2") .continueWithExecutor(BFExecutor.mainThreadExecutor(), withBlock: { (task:BFTask!) -> AnyObject! in
            if (task.error == nil) {
                if (task.result != nil) {
                    print(task.result)
                }
            } else {
                println("Error: \(task.error)")
                let alertController = UIAlertController(title: "Failed to get item from table.", message: task.error.description, preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action:UIAlertAction!) -> Void in
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
            return nil
        })

    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }

}

