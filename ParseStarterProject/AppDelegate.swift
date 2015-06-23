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
        /////////////////////////////////////////////////////////
        //MUST ENTER PARSE APP ID AND CLIENT KEY FOR APP TO RUN VVV//
        /////////////////////////////////////////////////////////
        Parse.setApplicationId("[Enter Id here]",
            clientKey: "[Enter client key here]")
        
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        return true
    }
}