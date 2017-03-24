//
//  Copyright (c) 2017 Emarsys. All rights reserved.
//

import UIKit
import Pushwoosh

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PushNotificationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        PushNotificationManager.push().delegate = self
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = PushNotificationManager.push().notificationCenterDelegate
        }
        PushNotificationManager.push().handlePushReceived(launchOptions)
        PushNotificationManager.push().sendAppOpen()
        PushNotificationManager.push().registerForPushNotifications()
        
        let config = MEConfig.make { builder in
            builder.setCredentialsWithApplicationId("14C19-A121F", applicationSecret: "PaNkfOD90AVpYimMBuZopCpm8OWCrREu")
        }
        MobileEngage.setup(with: config, launchOptions: launchOptions)
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        PushNotificationManager.push().handlePushRegistration(deviceToken as Data!)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        PushNotificationManager.push().handlePushRegistrationFailure(error)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        PushNotificationManager.push().handlePushReceived(userInfo)
    }

//MARK: PushNotificationDelegate
    func onPushAccepted(_ pushManager: PushNotificationManager!, withNotification pushNotification: [AnyHashable: Any]!, onStart: Bool) {
        MobileEngage.trackMessageOpen(userInfo: pushNotification)
    }

}
