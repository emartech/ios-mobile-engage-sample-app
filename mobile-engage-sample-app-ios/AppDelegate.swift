//
//  Copyright (c) 2017 Emarsys. All rights reserved.
//

import UIKit
import UserNotifications
import MobileEngageSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window?.tintColor = UIColor(red: 101 / 255.0, green: 151 / 255.0, blue: 207 / 255.0, alpha: 1.0)
        
        let config = MEConfig.make { builder in
            builder.setCredentialsWithApplicationCode("14C19-A121F", applicationPassword: "PaNkfOD90AVpYimMBuZopCpm8OWCrREu")
        }
        MobileEngage.setup(with: config, launchOptions: launchOptions)
        
        application.registerForRemoteNotifications()
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                print(granted, error ?? "no error")
            }
        } else {
            application.registerUserNotificationSettings(UIUserNotificationSettings.init(types: [.alert, .badge, .sound], categories: nil))
        }
        
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        MobileEngage.setPushToken(deviceToken)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {}

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        MobileEngage.trackMessageOpen(userInfo: userInfo)
    }

}
