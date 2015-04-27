//
//  DealCreateViewController.swift
//  Deal
//
//  Created by Do Kwon on 4/5/15.
//  Copyright (c) 2015 Do Kwon. All rights reserved.
//

import UIKit

class DealCreateViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    var tableView: UITableView = UITableView()
    
    required init(coder aDecoder: NSCoder) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //fatalError("init(coder:) has not been implemented")
        self.new_deal = Deal(task : "", reward :"", state_type: Deal.FilterType.PENDING, dealer_id : "", dealee_id : "")
        
        filtered_users = appDelegate.deal_data_manager!.deal_users.values.array
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var user_search_textfield: UITextField!
    
    var new_deal : Deal
    var resultSearchController = UISearchController()
    var dealee : User?
    var filtered_users : [User]
    
    func set_delee (user1: User) {
        self.dealee = user1
    }
    
    var parent_agreed : Bool = false
    var kid_agreed : Bool = false
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var rewardTextField: UITextField!
    @IBOutlet weak var makeDealBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTextField.delegate = self
        rewardTextField.delegate = self
        
        
        /* Initialize search results tableview */
        self.tableView.frame    =   CGRectMake(0, 100, 480, 200);
        tableView.delegate      =   self
        tableView.dataSource    =   self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: user_search_cell_identifier)
        
        /* No need to pick someone to deal with, so disable texfield interaction */
        if (self.dealee != nil) {
            self.user_search_textfield.userInteractionEnabled = false
            self.user_search_textfield.text = self.dealee!.First_Name + " " + self.dealee!.Last_Name
            self.new_deal.Dealee_Id = self.dealee!.User_Id
            self.user_search_textfield.textColor = UIColor.grayColor()
        }
    }
    
    @IBAction func user_search_changed(sender: UITextField) {
        filtered_users.removeAll(keepCapacity: false)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        for user in appDelegate.deal_data_manager!.deal_users.values.array {
            // Skip over myself
            if user.User_Id != appDelegate.deal_data_manager!.cur_user!.User_Id {
                let user_name = user.First_Name + " " + user.Last_Name
                if  user_name.lowercaseString.rangeOfString(sender.text) != nil {
                    filtered_users.append(user)
                }
            }
        }
        self.tableView.reloadData()
    }
    @IBAction func user_search_began(sender: AnyObject) {
        self.view.addSubview(tableView)
    }
    
    @IBAction func user_search_ended(sender: AnyObject) {
        tableView.removeFromSuperview()
    }
    
    @IBAction func user_search_discarded(sender: AnyObject) {
        self.view.endEditing(true)
        tableView.removeFromSuperview()
    }
    
    @IBAction func taskEntered(sender: AnyObject) {
        
        let new_task = taskTextField.text
        new_deal.Task = new_task
    }
    @IBAction func exit_pressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func rewardEntered(sender: AnyObject) {
        let new_reward = rewardTextField.text
        //new_deal.setReward(new_reward)
        new_deal.Reward = new_reward
    }
    
    @IBAction func makeDealBtnPressed(sender: AnyObject) {
        var errorMessage : String = ""
        if (rewardTextField.text == "" || taskTextField.text == "") {
            errorMessage = "You must enter both a task an a reward. Complete missing fields."
        } else if (self.dealee == nil) {
            errorMessage = "You must pick someone to deal with!"
            
        } else {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.deal_data_manager!.saveDeal(new_deal)
            
            self.dismissViewControllerAnimated(true, completion: nil)
            return
        }
        var alert = UIAlertController(title: "Alert", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered_users.count
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(user_search_cell_identifier, forIndexPath: indexPath)as? UITableViewCell
        let row = indexPath.row
        var user : User = filtered_users[row]
        cell!.textLabel!.text = user.First_Name + " " + user.Last_Name
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        self.dealee = filtered_users[row]
        self.user_search_textfield.text = self.dealee!.First_Name + " " + self.dealee!.Last_Name
        self.view.endEditing(true)
        self.new_deal.Dealee_Id = self.dealee!.User_Id
        tableView.removeFromSuperview()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
