//
//  MainViewController.swift
//  Deal
//
//  Created by Ki Suk Jang on 4/23/15.
//  Copyright (c) 2015 Ki Suk Jang. All rights reserved.
//

import UIKit
import CoreMotion

class MainViewController: UIViewController {
    @IBOutlet weak var mover: UIImageView!
    var motion_manager : CMMotionManager?
    var motion_display_link :CADisplayLink?
    
    var motion_last_yaw : Double = 0.0
    var motion_last_yaw_y : Double = 0.0
    
    @IBOutlet weak var my_icon: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize_deal_data()
        
        // Configure my icon
        configureMyIcon()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.motion_manager = CMMotionManager()
        self.motion_manager!.deviceMotionUpdateInterval = 0.02 // 50Hz
        
        // Get Contact List
        AddrBookService().requestAccess()
    }
    
    func motionRefresh() {
    
        let quat : CMQuaternion = self.motion_manager!.deviceMotion.attitude.quaternion
        //println(quat)
        var yaw : Double = asin(2*(quat.x*quat.z - quat.w*quat.y))
        println(yaw)
        if (self.motion_last_yaw == 0) {
            self.motion_last_yaw = yaw
        }
    
        // kalman filtering
        var q = 0.1   // process noise
        var r = 0.1   // sensor noise
        var p = 0.1   // estimated error
        var k = 0.5   // kalman filter gain
    
        var x = self.motion_last_yaw;
        //var y = self.motion_last_yaw;
        p = p + q
        k = p / (p + r)
        x = x + k*(yaw - x)
        //y = y + k*(yaw - y)
        p = (1 - k)*p
        self.motion_last_yaw = x
        //self.motion_last_yaw_y = y
        
        var new_frame = mover.frame;
        new_frame.origin.x -= CGFloat(x)    // shift right by 500pts
        //new_frame.origin.y -= CGFloat(y)
        
        UIView.animateWithDuration(0.001, animations: {
            self.mover.frame = new_frame
        })
      
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if (self.motion_manager!.deviceMotionAvailable) {
            //self.motion_manager?.startDeviceMotionUpdatesUsingReferenceFrame(CMAttitudeReferenceFrame.XArbitraryZVertical)
            self.motion_manager!.startDeviceMotionUpdates()
            let queue = NSOperationQueue.mainQueue()
            motion_manager!.startDeviceMotionUpdatesToQueue(queue) {
                (data, error) in
                self.motionRefresh()
            }
            
        }
    }
    
    /* Testing function. remove later */
    func initialize_deal_data() {
        
        let user_1 = "1"
        let user_2 = "2"
        let user_3 = "3"
        
        var jenny: UIImage = UIImage(named: "Jenny_Profile")!
        var jenny_nsdata: NSData = NSData(data: UIImagePNGRepresentation(jenny))
        var aime: UIImage = UIImage(named: "Aime_Profile")!
        var aime_nsdata: NSData = NSData(data: UIImagePNGRepresentation(aime))
        var jack: UIImage = UIImage(named: "Jack_Profile")!
        var jack_nsdata: NSData = NSData(data: UIImagePNGRepresentation(jack))
        
        
        let all_users = [User (id: user_1, first_name: "Aime", last_name: "Lindsay", photo: aime_nsdata), User (id: user_2, first_name: "Jenny", last_name: "Lindsay", photo: jenny_nsdata), User (id: user_3, first_name: "Jack", last_name: "Lindsay", photo: jack_nsdata)]
        
        let all_deals = [Deal(task: "Clean the house", reward: "Get Candy", deal_type: Deal.FilterType.ME_FILTER_TYPE, dealer_id : user_1, dealee_id : user_2),
            Deal(task: "Kiss your mom", reward: "Get money", deal_type: Deal.FilterType.ME_FILTER_TYPE, dealer_id : user_1, dealee_id : user_3),
            Deal(task: "Pick up grandma", reward: "Get licorice", deal_type: Deal.FilterType.FRIENDS_FILTER_TYPE, dealer_id : user_2, dealee_id : user_3),
            Deal(task: "Do homework", reward: "Get Xbox", deal_type: Deal.FilterType.ME_FILTER_TYPE, dealer_id : user_1, dealee_id : user_3),
            Deal(task: "Practice Piano", reward: "Get stoned", deal_type: Deal.FilterType.FAMILY_FILTER_TYPE, dealer_id : user_3, dealee_id : user_2),
            Deal(task: "Practice guitar", reward: "Get game gold", deal_type: Deal.FilterType.FRIENDS_FILTER_TYPE, dealer_id : user_2, dealee_id : user_3)
        ]
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        for deal in all_deals {
            appDelegate.deal_data_manager!.saveDeal(deal)
        }
        
        for user in all_users {
            appDelegate.deal_data_manager!.deal_users[user.User_Id] = user
        }
        appDelegate.deal_data_manager!.cur_user = all_users [0]
    }

    
    override func viewDidDisappear(animated: Bool) {
        self.motion_manager!.stopDeviceMotionUpdates()
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
        //my_icon.addMotionEffect(getMotionEffectGroup())
    }
}

