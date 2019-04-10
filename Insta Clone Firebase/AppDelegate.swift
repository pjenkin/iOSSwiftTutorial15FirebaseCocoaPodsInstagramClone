//
//  AppDelegate.swift
//  Insta Clone Firebase
//
//  Created by Peter Jenkin on 09/04/2019.
//  Copyright © 2019 Peter Jenkin. All rights reserved.
//

import UIKit
import Firebase // - cannot use XCode 8 or 9 with firebase as of 4/19 :(



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
 
    
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        rememberLogin()          // if user logged in already, skip signIn ViewController screen
        
        FirebaseApp.configure()  // this line d'require GoogleService-Info.plist in project - working with Firebase registration
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    /// bespoke function to remember user logged in to this app
    func rememberLogin()
    {
        let user: String? = UserDefaults.standard.string(forKey: "user")    // record with key user
        
        // skip login to main app controller using UIStoryboard, if already looged-in
        
        if user != nil
        {
            let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)  // NB type before assign/instantiate; also case sensitive "Main"
            let tabBar = board.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController     // for tab bar Controller in Main.Storyboard, make up/add an ID string in 'Identity' eg "tabBar" - use this here
            // beware auto-complete of .instantiate*Initial*ViewController :-/
            window?.rootViewController = tabBar     // like dragging storyboard entry-point arrow to TabBarController (in code)
            
            
        }

    }

}

