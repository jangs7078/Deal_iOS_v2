
//
//  DealContainerViewController.swift
//  Deal
//
//  Created by Do Kwon on 4/24/15.
//  Copyright (c) 2015 Ki Suk Jang. All rights reserved.
//

import UIKit

class DealContainerViewController: UIViewController {
  
    @IBAction func back_btn_pressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var add_deal_btn: UIButton!
    
    var dimmed_view : UIView?
    
    
    /* Dims the screen when speech recognition is activated
     */
    func dim_screen () {
        dimmed_view = UIView()
        dimmed_view!.bounds = UIScreen.mainScreen().bounds
        dimmed_view!.backgroundColor = UIColor.blackColor()
        dimmed_view!.alpha = 0.6
        self.view.addSubview(dimmed_view!)
    }
    
    /* Undims the screen when speech recognition finishes
     */
    func undim_screen (){
        dimmed_view!.removeFromSuperview()
    }
    
    func alert_user_create_deal_result (success : Bool) {
        var alert_title = "Command not understood"
        var alert_body = "Sorry, you're going to have to make the deal via text!"
        if (success) {
            alert_title = "Deal Created!"
            alert_body = "Deal created successfully."
        }
        var alert = UIAlertController(title: alert_title, message: alert_body, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    /* Function to add deals via voice UI.*/
    func add_deal_voice_pressed (longPress: UIGestureRecognizer) {
        if (longPress.state == UIGestureRecognizerState.Ended) {
            /* TODO: add voice interface here */
            let app_delegate = UIApplication.sharedApplication().delegate as! AppDelegate
            // Request using voice
            let apiai = app_delegate.apiai
            
            let request = apiai.requestWithType(AIRequestType.Voice) as! AIVoiceRequest
            
            request.setCompletionBlockSuccess({[unowned self] (AIRequest request, AnyObject response) -> Void in
                self.undim_screen()
                // Handle success ...
                println ("succeeded!!")
                println (response?.description)
                self.alert_user_create_deal_result (true)
                
                // Move back to deal result page
                self.dismissViewControllerAnimated(true, completion: nil)
                
                }, failure: { (AIRequest request, NSError error) -> Void in
                     self.undim_screen()
                    // Handle error ...
                    // Move to create deal via text, alert user of failure. 
                    println ("Request :" + request.description)
                    println (error)
                    
                    self.alert_user_create_deal_result (false)
                    self.performSegueWithIdentifier(make_deal_segue_identifier, sender: nil)
                    
            })
            
            apiai.enqueue(request)
            
        } else if (longPress.state == UIGestureRecognizerState.Began) {
            // For debug purposes.
            println("Began")
            dim_screen()
        }
    }
    
    
    func load_swipe_data() {
        /* Retrieve all deals from data manager */
        let app_delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manager : DataManager = app_delegate.deal_data_manager
        let all_deals : [Deal] = manager.deals
        
        
        if all_deals.count == 0 {
            // TODO : show that there are no deals present
            
        } else {
            /* 1) Create a scrollable viewcontroller showing the details of every deal,
            * and add to the scrollview. TODO: consider payloading deals in constant numbered
            * chunks to improve performance.
            */
            var page_count :Int = 0
            
            for deal in all_deals {
                let deal_detail_vc = DealDetailViewController(nibName:"DealDetailView", bundle:nil)
                deal_detail_vc.showing_deal = deal
                
                // 2) Add in each view to the container view hierarchy
                //    Add them in opposite order since the view hieracrhy is a stack
                self.addChildViewController(deal_detail_vc);
                self.scrollView!.addSubview(deal_detail_vc.view);
                deal_detail_vc.didMoveToParentViewController(self);
                
                // 3) Set up the frames of the view controllers to align
                //    with eachother inside the container view
                var adminFrame :CGRect = self.scrollView.frame
                adminFrame.origin.x = adminFrame.width * CGFloat (page_count)
                deal_detail_vc.view.frame = adminFrame
                
                // 4) Finally set the size of the scroll view that contains the frames
                var scrollWidth: CGFloat  = CGFloat(all_deals.count) * self.view.frame.width
                var scrollHeight: CGFloat  = self.view.frame.size.height
                self.scrollView!.contentSize = CGSizeMake(scrollWidth, scrollHeight);
                
                page_count += 1
            }
        }
    }
    
    /* Loads data in the swipeviewcontroller
     */
    override func viewDidAppear(animated: Bool) {
        load_swipe_data()
    }
    
    /* Will show everything inside this container */
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Initalize gestureRecongnizer for long touch of the add_deal button. */
        var gesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "add_deal_voice_pressed:")
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
