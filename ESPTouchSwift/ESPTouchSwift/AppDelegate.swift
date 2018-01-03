//
//  AppDelegate.swift
//  ESPTouchSwift
//
//  Created by Bruno Horta on 03/01/2018.
//  Copyright © 2018 VoidSteam. All rights reserved.
//

import UIKit

import SystemConfiguration.CaptiveNetwork
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ESP_NetUtil.tryOpenNetworkPermission()
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
        if let vc = self.window?.rootViewController as? ViewController{
            vc.ssidLabel.text = fetchSsid()
            vc.bssid = fetchBssid()
        }
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func  fetchSsid()->String{
        let ssidInfo = fetchNetInfo()
        
        return ssidInfo.value(forKey: "SSID") as! String
    }
    
    func fetchBssid()->String{
        let bssidInfo = fetchNetInfo()
        return bssidInfo.value(forKey: "BSSID") as! String
    }
    
    
    func fetchNetInfo()->NSDictionary
    {
        let interfaceNames: NSArray = CNCopySupportedInterfaces()!
        
        var SSIDInfo : NSDictionary?
        for interfaceName in interfaceNames {
            SSIDInfo =   CNCopyCurrentNetworkInfo(interfaceName as! CFString)!
        }
        
        return SSIDInfo!;
    }

}

