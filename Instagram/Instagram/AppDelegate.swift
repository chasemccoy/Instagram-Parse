//
//  AppDelegate.swift
//  Instagram
//
//  Created by Chase McCoy on 3/1/16.
//  Copyright © 2016 Chase McCoy. All rights reserved.
//

import UIKit
import Parse

let storyboard = UIStoryboard.init(name: "Main", bundle: nil)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: "userDidLogout", object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogin", name: "userDidLogin", object: nil)
    
    // Initialize Parse
    // Set applicationId and server based on the values in the Heroku settings.
    // clientKey is not used on Parse open source unless explicitly configured
    Parse.initializeWithConfiguration(
      ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
        configuration.applicationId = "Instagram"
        configuration.clientKey = "aksdbia234iauds283g2739g2ea"
        configuration.server = "https://afternoon-ravine-61444.herokuapp.com/parse"
      })
    )
    
    // check if user is logged in.
    if PFUser.currentUser() != nil {
      userDidLogin()
    }
    
    return true
  }
  
  func userDidLogin() {
    let vc = storyboard.instantiateViewControllerWithIdentifier("TabBarController")
    window?.rootViewController = vc
  }
  
  func userDidLogout() {
    PFUser.logOut()
    let vc = storyboard.instantiateViewControllerWithIdentifier("LoginViewController")
    window?.rootViewController = vc
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

