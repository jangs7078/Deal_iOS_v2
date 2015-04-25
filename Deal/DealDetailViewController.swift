//
//  DealDetailViewController.swift
//  Deal
//
//  Created by Do Kwon on 4/24/15.
//  Copyright (c) 2015 Ki Suk Jang. All rights reserved.
//

import UIKit

class DealDetailViewController: UIViewController {
    
    /* IBAction function to add deals via text. */
    @IBAction func add_deal_text_pressed(sender: AnyObject) {
        
    }
    
    /* Function to add deals via voice UI.*/
    func add_deal_voice_pressed (longPress: UIGestureRecognizer) {
        
        if (longPress.state == UIGestureRecognizerState.Ended) {
            /* TODO: add voice interface here */
            println("Ended")
            
        } else if (longPress.state == UIGestureRecognizerState.Began) {
            // For debug purposes.
            println("Began")
            
        }
        
    }
    
    
    @IBOutlet weak var add_deal_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Initalize gestureRecongnizer for long touch of the add_deal button. */
        var gesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: " add_deal_voice_pressed:")
        gesture.minimumPressDuration = 1.0
        self.view.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
