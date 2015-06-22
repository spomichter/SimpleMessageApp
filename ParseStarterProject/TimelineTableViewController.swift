//
//  TimelineTableViewController.swift
//  ParseStarterProject
//
//  Created by Stash Pomichter on 6/20/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class TimelineTableViewController: UITableViewController
{
    var timelineData: NSMutableArray = NSMutableArray()
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    @IBAction func loadData(){
        timelineData.removeAllObjects()
        
        var findData: PFQuery = PFQuery(className: "Texts")
        
        findData.findObjectsInBackgroundWithBlock({
            (objects:[AnyObject]?, error:NSError?)->Void in
            
            if !(error != nil) {
                for object in objects! {
                    self.timelineData.addObject(object)
                }
                
                var array:NSArray = self.timelineData.reverseObjectEnumerator().allObjects
                self.timelineData = NSMutableArray(array: array)
                
                self.tableView.reloadData()
                
            }
        })
    }
    

    override func viewDidAppear(animated: Bool)
    {
        
        self.loadData()

        if !(PFUser.currentUser() != nil)
        {
            var loginAlert: UIAlertController = UIAlertController(title: "Sign Up / Login", message: "Please sign up or login", preferredStyle: UIAlertControllerStyle.Alert)
            
            loginAlert.addTextFieldWithConfigurationHandler({
                    textfield in
                    textfield.placeholder = "Your username"
                })
            
            loginAlert.addTextFieldWithConfigurationHandler({
                    textfield in
                    textfield.placeholder = "Your password"
                    textfield.secureTextEntry = true
                })
            
            loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                let textFields: NSArray = loginAlert.textFields! as NSArray
                let usernameTextfield: UITextField! = textFields.objectAtIndex(0) as! UITextField
                let passwordTextfield: UITextField! = textFields.objectAtIndex(1) as! UITextField
                let username: String = usernameTextfield.text
                let password: String = passwordTextfield.text
                    
                    
                PFUser.logInWithUsernameInBackground(username, password: password){
                        (user:PFUser?, error:NSError?)->Void in

                        if (user != nil)
                        {
                            println("Login Success!")
                        }else{
                            println("Login Failed!")
                        }

                }
                
            }))
            
            
            loginAlert.addAction(UIAlertAction(title: "Sign Up", style: UIAlertActionStyle.Default, handler: {
                
                alertAction in
                let textFields: NSArray = loginAlert.textFields! as NSArray
                let usernameTextfield: UITextField! = textFields.objectAtIndex(0) as! UITextField
                let passwordTextfield: UITextField! = textFields.objectAtIndex(1) as! UITextField
                let username: String = usernameTextfield.text
                let password: String = passwordTextfield.text
                
                var texter: PFUser = PFUser()
                texter.username = usernameTextfield.text
                texter.password = passwordTextfield.text
                
                texter.signUpInBackgroundWithBlock{
                    (success:Bool, error:NSError?) -> Void in
                    
                    if !(error != nil)
                    {
                        println("Sign up successful!")
                    }else
                    {
                        let errorString = error!.userInfo
                        println(errorString)
                    }
                }
                
                    
            }))

            self.presentViewController(loginAlert, animated: true, completion: nil)

        }
    
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         //#warning Incomplete method implementation.
         //Return the number of rows in the section.
        return timelineData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: cellTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! cellTableViewCell

        let text: PFObject = self.timelineData.objectAtIndex(indexPath.row) as! PFObject
        
        cell.usernameLabel.alpha = 0
        cell.dateLabel.alpha = 0
        cell.cellTextView.alpha = 0
        
        cell.cellTextView.text = text.objectForKey("content") as! String
        
        
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        cell.dateLabel.text = dateFormatter.stringFromDate(text.createdAt!)
        
        
        var findUser: PFQuery! = PFUser.query()
        if text.objectForKey("texter")?.objectId != nil{
            let objectId: String = text.objectForKey("texter")!.objectId!!
            findUser.whereKey("objectId", equalTo: objectId)
        }
        
        findUser.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if !(error != nil){
                let user: PFUser = (objects! as NSArray).lastObject as! PFUser
                cell.usernameLabel.text = user.username
            }
            
        }
        
        UIView.animateWithDuration(0.5, animations:{
            cell.usernameLabel.alpha = 1
            cell.dateLabel.alpha = 1
            cell.cellTextView.alpha = 1
            
            })
        
        return cell

    }
}