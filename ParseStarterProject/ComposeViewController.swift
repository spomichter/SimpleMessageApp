//
//  ComposeViewController.swift
//  ParseStarterProject
//
//  Created by Stash Pomichter on 6/20/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet var textView: UITextView! = UITextView()
    @IBOutlet var charRemaining: UILabel! = UILabel()
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.layer.borderColor = UIColor.blackColor().CGColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        
        textView.becomeFirstResponder()
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func send(sender: AnyObject)
    {
        var text: PFObject = PFObject(className: "Texts")
        text["content"] = textView.text
        text["texter"] = PFUser.currentUser()
        
        text.saveInBackground()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

}
