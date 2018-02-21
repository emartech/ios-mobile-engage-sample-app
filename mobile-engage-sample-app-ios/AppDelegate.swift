//
//  Copyright (c) 2017 Emarsys. All rights reserved.
//

import UIKit
import UserNotifications
import MobileEngageSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MEInAppMessageHandler {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window?.tintColor = UIColor(red: 101 / 255.0, green: 151 / 255.0, blue: 207 / 255.0, alpha: 1.0)

        let config = MEConfig.make { builder in
            builder.setExperimentalFeatures([INAPP_MESSAGING]);
            if let applicationCode = ProcessInfo.processInfo.environment["applicationCode"] as? String,
               let applicationPassword = ProcessInfo.processInfo.environment["applicationPassword"] as? String {
                builder.setCredentialsWithApplicationCode(applicationCode, applicationPassword: applicationPassword)
            } else {
#if DEBUG
                builder.setCredentialsWithApplicationCode("14C19-A121F", applicationPassword: "PaNkfOD90AVpYimMBuZopCpm8OWCrREu")
#else
                builder.setCredentialsWithApplicationCode("EMS5D-F1638", applicationPassword: "U1T/s8JG6QcRKGckFbuz/yVekNappWAl")
#endif
            }
        }
        MobileEngage.setup(with: config, launchOptions: launchOptions);
        MobileEngage.inApp.messageHandler = self

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

    func handleApplicationEvent(_ eventName: String, payload: [String: NSObject]?) {
        print(eventName, payload)
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        MobileEngage.setPushToken(deviceToken)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        MobileEngage.trackMessageOpen(userInfo: userInfo)
    }

}
