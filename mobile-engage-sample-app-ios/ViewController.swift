//
//  Copyright (c) 2017 Emarsys. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MobileEngageStatusDelegate {

//MARK: Outlets
    @IBOutlet weak var contactFieldIdTextField: UITextField!
    @IBOutlet weak var contactFieldValueTextField: UITextField!
    @IBOutlet weak var sidTextField: UITextField!
    @IBOutlet weak var customEventNameTextField: UITextField!
    @IBOutlet weak var customEventAttributesTextView: UITextView!

//MARK: ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        MobileEngage.statusDelegate = self;
    }

//MARK: Actions
    @IBAction func anonymLoginButtonClicked(_ sender: Any) {
        MobileEngage.appLogin()
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
        if let idText = self.contactFieldIdTextField.text,
           let valueText = self.contactFieldValueTextField.text,
           let id = Int(idText) {
            MobileEngage.appLogin(withContactFieldId: id as NSNumber, contactFieldValue: valueText)
        } else {
            MobileEngage.appLogin(withContactFieldId: nil, contactFieldValue: nil)
        }
    }

    @IBAction func trackMessageButtonClicked(_ sender: Any) {
        guard let sidText = sidTextField.text,
              let sid = Int(sidText) else {
            return
        }
        MobileEngage.trackMessageOpen(userInfo: ["u": "{\"sid\":\"\(sid)\"}"])
    }

    @IBAction func trackCustomEventButtonClicked(_ sender: Any) {
    }

    @IBAction func logoutButtonClicked(_ sender: Any) {
    }

    func backgroundTapped() {
        self.view.endEditing(true)
    }

//MARK: MobileEngageStatusDelegate
    func mobileEngageLogReceived(withEventId eventId: String, log: String) {
        print(eventId, log)
    }

    func mobileEngageErrorHappened(withEventId eventId: String, error: Error) {
        print(eventId, error)
    }

}
