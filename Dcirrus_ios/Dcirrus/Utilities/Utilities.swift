//
//  Utilities.swift
//  Dcirrus
//
//  Created by Binesh Pavithran on 25/03/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit
import SwiftMessages
import NVActivityIndicatorView
import Darwin

class Utilities : NSObject{
    class func showCustomAlert(title : String = "" , message : String = "" , imageName
                                : String = "" , presentingView
                                    : UIViewController ) {
        let alertView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomAlertViewController") as! CustomAlertViewController
        alertView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertView.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        presentingView.present(alertView, animated: false) {
            
        }
    }
    class func showCustomActionSheet(buttonNames : [String] = [""] , buttonImages : [String] = [""] , presentingView
                                        : UIViewController ) {
        let alertView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomActionSheetViewController") as! CustomActionSheetViewController
        alertView.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        alertView.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        alertView.buttonNames = buttonNames
        alertView.buttonImages = buttonImages
        alertView.delegate = presentingView as? DownloadsViewController
        presentingView.present(alertView, animated: false) {
            
        }
    }
    class func setRootViewController(vcName : String  , storyBoardName : String = "Main") {
        let mainStoryBoard = UIStoryboard(name: storyBoardName, bundle: nil)
        let rootViewController = mainStoryBoard.instantiateViewController(withIdentifier: vcName)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootViewController
    }
    class func titleLabel() -> UILabel {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        titleLabel.font = UINavigationBar.appearance().titleTextAttributes?[NSAttributedString.Key.font] as? UIFont
        titleLabel.textColor = UIColor.hexStringToUIColor(hex: "102168")
        return titleLabel
    }
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

//App Constant
var appVersion: String = "1.0"


//MARK:- GCD
func getMainQueue(completion: @escaping (() -> Void)) {
    DispatchQueue.main.async {
        completion()
    }
}
func getDelayMainQueue(delay: Double, completion: @escaping (() -> Void)) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        completion()
    }
}
func getBackgroundQueue(qos: DispatchQoS.QoSClass = DispatchQoS.QoSClass.background, completion: @escaping (() -> Void)){
    DispatchQueue.global(qos: qos).async {
        completion()
    }
}

//MARK:- Get App Current Version
func getAppVersion() -> String{
    if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
        appVersion = version
    }
    return appVersion
}


//MARK:- Show / Hide Activity Indicator
func showIndicator(){
    getMainQueue {
        let activityData = ActivityData(type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.red)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
}

func hideIndicator(){
    getMainQueue {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}

//MARK: - Show Message
func showInfoMessage(messsage: String) {
    let success = MessageView.viewFromNib(layout: .cardView)
    success.configureTheme(Theme.success)
    //success.configureTheme(backgroundColor: UIColor.white, foregroundColor: UIColor.black)
    success.configureDropShadow()
    success.backgroundView.backgroundColor = UIColor.white//.withAlphaComponent(0.7)
    success.configureContent(title: nil, body: messsage, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: nil)
    success.bodyLabel?.textAlignment = .center
    success.bodyLabel?.font = UIFont.systemFont(ofSize: 18.0)
    success.bodyLabel?.textColor = UIColor.black
    //configureContent(title: type, body: messsage)
    success.button?.isHidden = true
    var successConfig = SwiftMessages.defaultConfig
    successConfig.presentationStyle = .top
    successConfig.interactiveHide = true
    // successConfig.presentationContext =    .window(windowLevel: UIWindow.Level.statusBar)
    SwiftMessages.show(config: successConfig, view: success)
}


func getIPAddress()-> String? {
    
    var address: String?
    var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
    if getifaddrs(&ifaddr) == 0 {
        
        var ptr = ifaddr
        while ptr != nil {
            defer { ptr = ptr?.pointee.ifa_next } // memory has been renamed to pointee in swift 3 so changed memory to pointee
            
            let interface = ptr?.pointee
            let addrFamily = interface?.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                if let ifa_name = (interface?.ifa_name) {
                    let name: String = String(cString: ifa_name)
                    if name == "en0" {
                        // String.fromCString() is deprecated in Swift 3. So use the following code inorder to get the exact IP Address.
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
        }
        freeifaddrs(ifaddr)
    }
    
    return address
}
