
//
//  DealContainerViewController.swift
//  Deal
//
//  Created by Do Kwon on 4/24/15.
//  Copyright (c) 2015 Ki Suk Jang. All rights reserved.
//

import UIKit

class DealContainerViewController: UIViewController {
    
    /* IBAction function to add deals via text. */
    @IBAction func add_deal_text_pressed(sender: AnyObject) {
        
    }
    
    @IBOutlet weak var add_deal_btn: UIButton!
    /* Function to add deals via voice UI.*/
    
    
    func add_deal_voice_pressed () {
        
        /*if (longPress.state == UIGestureRecognizerState.Ended) {
            /* TODO: add voice interface here */
            println("Ended")
            
        } else if (longPress.state == UIGestureRecognizerState.Began) {
            // For debug purposes.
            println("Began")
        }*/
    }
    

    /* Will show everything inside this container */
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Retrieve all deals from data manager */
        let app_delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manager : DataManager = app_delegate.deal_data_manager
        let all_deals : [Deal] = manager.deals
        
        
        
        if all_deals.count == 0 {
            // TODO : show that there are no deals present
            
        } else {
            /* Create a scrollable viewcontroller showing the details of every deal,
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
    
        
        /* Initalize gestureRecongnizer for long touch of the add_deal button. */
        var gesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: " add_deal_voice_pressed")
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
