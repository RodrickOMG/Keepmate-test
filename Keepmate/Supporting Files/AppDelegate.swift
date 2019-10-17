//
//  AppDelegate.swift
//  Keepmate
//
//  Created by Rodrick Dai on 2019/7/12.
//  Copyright © 2019 Rodrick Dai. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        Bmob.register(withAppKey: "01ede73d2d741f7f6a27ae3cfe18bb93")
        
        Thread .sleep(forTimeInterval: 1)
        // 检测用户是不是第一次启动
        if UserDefaults.standard.bool(forKey: "everLaunched") == false {
            // 是第一次启动
            UserDefaults.standard.set(true, forKey: "firstLaunched")
            UserDefaults.standard.set(true, forKey: "everLaunched")
            print("first launch")
            let stb = UIStoryboard(name: "BWWalkthrough", bundle: nil)
            let walkthrough = stb.instantiateViewController(withIdentifier: "walk") as! BWWalkthroughViewController
            let page_zero = stb.instantiateViewController(withIdentifier: "walk0")
            let page_one = stb.instantiateViewController(withIdentifier: "walk1")
            let page_two = stb.instantiateViewController(withIdentifier: "walk2")
            let page_three = stb.instantiateViewController(withIdentifier: "walk3")
            
            walkthrough.delegate = self as? BWWalkthroughViewControllerDelegate
            walkthrough.add(viewController: page_one)
            walkthrough.add(viewController: page_two)
            walkthrough.add(viewController: page_three)
            walkthrough.add(viewController: page_zero)
            
            self.window?.rootViewController = walkthrough
        } else {
            UserDefaults.standard.set(false, forKey: "firstLaunched")
            let user = BmobUser.current()
            if user == nil {
                let sb = UIStoryboard(name:"LoginAndRegister",bundle: Bundle.main)
                let vc = sb.instantiateViewController(withIdentifier: "Login")
                vc.modalPresentationStyle = .fullScreen
                self.window?.rootViewController = vc
            }
            print("ever launched")
        }
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
    
    func walkthroughPageDidChange(_ pageNumber: Int) {
        print("Current Page \(pageNumber)")
    }
    

}

