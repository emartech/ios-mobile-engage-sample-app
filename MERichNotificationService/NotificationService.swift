//
//  Copyright © 2017. Emarsys. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
            
        guard let content = request.content.mutableCopy() as? UNMutableNotificationContent else {
            contentHandler(request.content)
            return
        }
        guard let attachmentURL = content.userInfo["attachment-url"] as? String else {
            contentHandler(request.content)
            return
        }
        guard let url = URL(string: attachmentURL) else {
            contentHandler(request.content)
            return
        }
        guard let imageData = NSData(contentsOf:url) else {
            contentHandler(request.content)
            return
        }
        guard let attachment = UNNotificationAttachment.create(imageFileIdentifier: "image.gif", data: imageData, options: nil) else {
            contentHandler(request.content)
            return
        }
        
        content.categoryIdentifier = "customContentIdentifier"
        
        content.attachments = [attachment]
        contentHandler(content.copy() as! UNNotificationContent)
    }
    
    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}


extension UNNotificationAttachment {
    
    static func create(imageFileIdentifier: String, data: NSData, options: [NSObject: AnyObject]?) -> UNNotificationAttachment? {
        do {
            let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(imageFileIdentifier)
            try data.write(to: fileURL, options: [])
            let imageAttachment = try UNNotificationAttachment(identifier: imageFileIdentifier, url: fileURL, options: options)
            return imageAttachment
        } catch let error {
            print("error \(error)")
        }
        return nil
    }
}
