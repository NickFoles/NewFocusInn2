//
//  AppDelegate.swift
//  NewFocusInn
//
//  Created by Dara Oseyemi (student LM) on 1/29/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import UserNotifications

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var vc = FocusingViewController()
    var ref: DatabaseReference!
    let defaults = UserDefaults.standard
    
//    let displayStatusChanged: CFNotificationCallback = { center, observer, name, object, info in
//        let str = name!.rawValue as CFString
//        if (str == "com.apple.springboard.lockcomplete" as CFString) {
//            let isDisplayStatusLocked = UserDefaults.standard
//            isDisplayStatusLocked.set(true, forKey: "isDisplayStatusLocked")
//            isDisplayStatusLocked.synchronize()
//        }
//    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {(granted, error) in
            //  return true
            print("granted")
        }
        
//        let isDisplayStatusLocked = UserDefaults.standard
//        isDisplayStatusLocked.set(false, forKey: "isDisplayStatusLocked")
//        isDisplayStatusLocked.synchronize()
//
//        // Darwin Notification
//        let cfstr = "com.apple.springboard.lockcomplete" as CFString
//        let notificationCenter = CFNotificationCenterGetDarwinNotifyCenter()
//        let function = displayStatusChanged
//        CFNotificationCenterAddObserver(notificationCenter, nil, function, cfstr, nil, .deliverImmediately)
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        //        print("Storing Exit Time")
        //        vc.storeExitTime()
        
        //        print("Sending Time Left Notification")
        //        vc.timeLeftNotification()
        print("Test123.")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        //vc.exitEarly()
        
//        let isDisplayStatusLocked = UserDefaults.standard
//        if let lock = isDisplayStatusLocked.value(forKey: "isDisplayStatusLocked"){
//
//            // user locked screen
//            if(lock as! Bool){
//                // do anything you want here
//                print("Lock button pressed.")
//            }
//                // user pressed home button
//            else{
//                // do anything you want here
//                if application.topViewController is FocusingViewController {
//                    print("Failure Notification Here")
//                    vc.failureNotification()
//                }
//                print("Home button pressed.")
//            }
//        }
        
        if application.topViewController is FocusingViewController {
            vc.timeLeftNotification()
            vc.failureNotification()}
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
//            print("Back to foreground.")
//            //restore lock screen setting
//            let isDisplayStatusLocked = UserDefaults.standard
//            isDisplayStatusLocked.set(false, forKey: "isDisplayStatusLocked")
//            isDisplayStatusLocked.synchronize()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        let user = Auth.auth().currentUser
        if user != nil {
            ref = Database.database().reference().child("users").child(user!.uid)
            
            // list of buildings corresponding to city coordinates and sessions
            ref!.child("houseList").observeSingleEvent(of: .value, with: { (snapshot) in
                houseList  = snapshot.value as! [String]
            })
            ref?.child("sessions").observeSingleEvent(of: .value, with: { (snapshot) in
                sessions = snapshot.value as! Int
            })
            
            // timeline history and dates
            ref!.child("timelineHistory").observeSingleEvent(of: .value, with: { (snapshot) in
                timelineHistory = snapshot.value as! [[String]]
            })
            ref!.child("dates").observeSingleEvent(of: .value, with: { (snapshot) in
                dates = snapshot.value as! [String]
            })
            
            // achievements and total focusing time
            ref?.child("totalMinutes").observeSingleEvent(of: .value, with: { (snapshot) in
                totalTime = snapshot.value as! Int
            })
            ref?.child("achievementList").observeSingleEvent(of: .value, with: { (snapshot) in
                achievements = snapshot.value as! [Int]
            })
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func getVisibleViewController(_ rootViewController: UIViewController?) -> UIViewController? {
        var rootVC = rootViewController
        if rootVC == nil {
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }
        
        if rootVC?.presentedViewController == nil {
            return rootVC
        }
        
        if let presented = rootVC?.presentedViewController {
            if presented.isKind(of: UINavigationController.self) {
                let navigationController = presented as! UINavigationController
                return navigationController.viewControllers.last!
            }
            
            if presented.isKind(of: UITabBarController.self) {
                let tabBarController = presented as! UITabBarController
                return tabBarController.selectedViewController!
            }
            
            return getVisibleViewController(presented)
        }
        return nil
    }
}

//Found on Github. - https://gist.github.com/snikch/3661188

extension UIApplication{
    var topViewController: UIViewController?{
        if keyWindow?.rootViewController == nil{
            return keyWindow?.rootViewController
        }
        
        var pointedViewController = keyWindow?.rootViewController
        
        while  pointedViewController?.presentedViewController != nil {
            switch pointedViewController?.presentedViewController {
            case let navagationController as UINavigationController:
                pointedViewController = navagationController.viewControllers.last
            case let tabBarController as UITabBarController:
                pointedViewController = tabBarController.selectedViewController
            default:
                pointedViewController = pointedViewController?.presentedViewController
            }
        }
        return pointedViewController
        
    }
}
