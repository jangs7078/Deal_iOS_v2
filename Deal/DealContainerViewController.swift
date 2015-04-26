
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
    
    /* Function to add deals via voice UI.*/
    func add_deal_voice_pressed (longPress: UIGestureRecognizer) {
        if (longPress.state == UIGestureRecognizerState.Ended) {
            /* TODO: add voice interface here */
             let app_delegate = UIApplication.sharedApplication().delegate as! AppDelegate
            // Request using voice
            let apiai = app_delegate.apiai
            
            let request = apiai.requestWithType(AIRequestType.Voice) as! AIVoiceRequest
            
            request.setCompletionBlockSuccess({[unowned self] (AIRequest request, AnyObject response) -> Void in
                // Handle success ...
                println ("succeeded!!")
                
                }, failure: { (AIRequest request, NSError error) -> Void in
                    // Handle error ...
            })
            
            apiai.enqueue(request)
            
        } else if (longPress.state == UIGestureRecognizerState.Began) {
            // For debug purposes.
            println("Began")
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
