//
//  PostCell.swift
//  Instagram
//
//  Created by Chase McCoy on 3/4/16.
//  Copyright © 2016 Chase McCoy. All rights reserved.
//

import UIKit
import Parse
import AFNetworking

class PostCell: UITableViewCell {
  @IBOutlet var postImageView: UIImageView!
  @IBOutlet var captionLabel: UILabel!
  
  var post: PFObject! {
    didSet {
      captionLabel.text = post["caption"] as? String
      
      let file = post["media"] as? PFFile
      let url = NSURL(string: (file?.url)!)
      postImageView.setImageWithURL(url!)
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

}
