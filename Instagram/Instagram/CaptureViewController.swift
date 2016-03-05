//
//  CaptureViewController.swift
//  Instagram
//
//  Created by Chase McCoy on 3/4/16.
//  Copyright © 2016 Chase McCoy. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @IBOutlet var capturedImageView: UIImageView!
  @IBOutlet var captionField: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func addButtonPressed(sender: UIButton) {
    let vc = UIImagePickerController()
    vc.delegate = self
    vc.allowsEditing = true
    vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    
    self.presentViewController(vc, animated: true, completion: nil)

  }
  
  func imagePickerController(picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [String : AnyObject]) {
      // Get the image captured by the UIImagePickerController
      //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
      let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
      
      // Do something with the images (based on your use case)
      capturedImageView.image = editedImage
      
      // Dismiss UIImagePickerController to go back to your original view controller
      dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func postButtonPressed(sender: UIBarButtonItem) {
    Post.postUserImage(capturedImageView.image, withCaption: captionField.text) { (success: Bool, error: NSError?) -> Void in
      self.captionField.text = nil
      self.capturedImageView.image = nil
      self.tabBarController?.selectedIndex = 0
    }
  }
  
  func resize(image: UIImage, newSize: CGSize) -> UIImage {
    let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
    resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
    resizeImageView.image = image
    
    UIGraphicsBeginImageContext(resizeImageView.frame.size)
    resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
