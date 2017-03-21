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
        guard let idText = self.contactFieldIdTextField.text,
              let valueText = self.contactFieldValueTextField.text,
              let id = Int(idText) else {
            showAlert(with: "Wrong parameter")
            return
        }
        MobileEngage.appLogin(withContactFieldId: id as NSNumber, contactFieldValue: valueText)
    }

    @IBAction func trackMessageButtonClicked(_ sender: Any) {
        guard let sidText = sidTextField.text,
              let sid = Int(sidText) else {
            showAlert(with: "Missing sid")
            return
        }
        MobileEngage.trackMessageOpen(userInfo: ["u": "{\"sid\":\"\(sid)\"}"])
    }

    @IBAction func trackCustomEventButtonClicked(_ sender: Any) {
        guard let eventName = self.customEventNameTextField.text, !eventName.isEmpty else {
            showAlert(with: "Missing eventName")
            return
        }
        var eventAttributes: [String: String]?
        if let attributes = self.customEventAttributesTextView.text {
            if let data = attributes.data(using: .utf8) {
                do {
                    eventAttributes = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
                } catch {
                    showAlert(with: "Invalid JSON")
                    print(error.localizedDescription)
                }
            }
        }
        MobileEngage.trackCustomEvent(eventName, eventAttributes: eventAttributes)
    }

    @IBAction func logoutButtonClicked(_ sender: Any) {
        MobileEngage.appLogout()
    }

    func backgroundTapped() {
        self.view.endEditing(true)
    }

//MARK: MobileEngageStatusDelegate
    func mobileEngageLogReceived(withEventId eventId: String, log: String) {
        showAlert(with: "EventId: \(eventId) \n Log: \(log)")
        print(eventId, log)
    }

    func mobileEngageErrorHappened(withEventId eventId: String, error: Error) {
        showAlert(with: "EventId: \(eventId) \n Error: \(error)")
        print(eventId, error)
    }

//MARK: Private methods
    fileprivate func showAlert(with message: String) {
        let controller = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(controller, animated: true)
    }

}
