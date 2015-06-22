//
//  AppDelegate.swift

import UIKit
import Bolts
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        UINavigationBar.appearance().barTintColor = UIColor.greenColor()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        Parse.enableLocalDatastore()
        
        Parse.setApplicationId("AeMw4SpjA4vCraY1zB59yDAGQ1mpqUrL1qYyEMrr",
            clientKey: "PdHNdEQnYwlkdoh2BLu88OWApaeCgxgfLfIp3Lhx")
        
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        return true
    }
}