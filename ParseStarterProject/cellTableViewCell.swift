//
//  cellTableViewCell.swift
//  ParseStarterProject
//
//  Created by Stash Pomichter on 6/20/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//


import UIKit

class cellTableViewCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var cellTextView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellTextView.layer.borderColor = UIColor.blackColor().CGColor
        cellTextView.layer.borderWidth = 0.5
        }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
