//
//  Copyright © 2017. Emarsys. All rights reserved.
//

import Foundation
import UIKit

class MESInboxViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//MARK: Outlets
    @IBOutlet weak var notificationTableView: UITableView!
    
//MARK: Variables
    var notifications: [MENotification] = []
    
//MARK: ViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MobileEngage.inbox.fetchNotifications(resultBlock: { [unowned self] notificationInboxStatus in
            guard let inboxStatus = notificationInboxStatus else { return }
            self.notifications = inboxStatus.notifications
            self.notificationTableView.reloadData()
        }) { error in
            print(error)
        }
    }

//MARK: UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = notifications[indexPath.row].title
        
        return cell
    }

}
