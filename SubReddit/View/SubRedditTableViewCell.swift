//
//  SubRedditTableViewCell.swift
//  SubReddit
//
//  Created by Caston  Boyd on 5/23/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

import UIKit

class SubRedditTableViewCell: UITableViewCell {

    @IBOutlet weak var subRedditImageView: UIImageView!
    @IBOutlet weak var subRedditTitle: UILabel!
    @IBOutlet weak var numOfComments: UILabel!
    @IBOutlet weak var numOfUpvotes: UILabel!
    
    var posts: Post?{
        didSet {
            updateViews()
        }
    }
    
    var thumbNail: UIImage? {
        didSet{
            updateViews()
        }
        
    }
    
    func updateViews() {
        guard let post = posts else { return }
        
        if let thumbNail = thumbNail {
            subRedditImageView.image = thumbNail
            
        } else {
            
         subRedditImageView.image = UIImage(named: "No")
            
        }
       
        subRedditTitle.text = "\(String(describing: post.title))"
        numOfComments.text = "\(String(describing: post.numberOfComments))"
        numOfUpvotes.text = "\(String(describing: post.numberOfUpVotes))"
        
    }

}
