//
//  AppDelegate.swift
//  Dcirrus
//
//  Created by Gaadha on 17/09/19.
//  Copyright © 2019 Goodbits. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Toast_Swift
import ObjectMapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.hexStringToUIColor(hex: "102168") , NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 17.0)!]
        UINavigationBar.appearance().tintColor = UIColor.hexStringToUIColor(hex: "102168")
        var style = ToastStyle()
        style.backgroundColor = Utilities.hexStringToUIColor (hex:"2ABFC1") //2ABFC1
        ToastManager.shared.style = style
        self.isLogin()
        self.otherConfiguration()
        
        return true
    }

    //MARK: -
    func isLogin(){
        if let objResponse = getValueFromPreference(forKey: Preference.logedInUser) as? [String: Any] {
            objLogedInUser =  Mapper().map(JSON: objResponse)
            if let token = getValueFromPreference(forKey: Preference.token) as? String {
                Constants.token = token
            }
            let loginViewModel = LoginViewModel()
            loginViewModel.loginaction()
        }
    }
    func otherConfiguration(){
        _ = DirectoryManager.createDir(dirName: Constant.downloadedDocument)
        
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

    func logout() {
        let rootView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootNavigationId")
        //let rootView = UINavigationController(rootViewController: loginView)
        self.window?.rootViewController = rootView
    }
}

