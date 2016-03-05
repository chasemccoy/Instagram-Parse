//
//  FeedViewController.swift
//  Instagram
//
//  Created by Chase McCoy on 3/4/16.
//  Copyright © 2016 Chase McCoy. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDataSource {
  @IBOutlet var tableView: UITableView!
  
  var posts: [PFObject]?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.rowHeight = 320
    
    refreshData()
  }
  
  func refreshData() {
    // construct PFQuery
    let query = PFQuery(className: "Post")
    query.orderByDescending("createdAt")
    query.includeKey("author")
    query.limit = 20
    
    // fetch data asynchronously
    query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
      if let media = media {
        self.posts = media
        self.tableView.reloadData()
      } else {
        // handle error
      }
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let posts = posts {
      return posts.count
    }
    else {
      return 0
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostCell
    
    cell.post = posts![indexPath.row]
    
    return cell
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
