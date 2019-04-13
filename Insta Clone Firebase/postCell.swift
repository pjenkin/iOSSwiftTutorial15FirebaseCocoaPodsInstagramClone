//
//  postCell.swift
//  Insta Clone Firebase
//
//  Created by Peter Jenkin on 11/04/2019.
//  Copyright © 2019 Peter Jenkin. All rights reserved.
//

import UIKit

class postCell: UITableViewCell {

    //@IBOutlet weak var usernameLabel: UILabel!
    // treid manually not drag/drop
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var postComment: UITextView!
    // @IBOutlet weak var postComment: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
