//
//  ViewController.swift
//  StateRestoration
//
//  Created by Fauad Anwar on 12/07/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func updateUserActivity() {
        var currentUserActivity = view.window?.windowScene?.userActivity
        if currentUserActivity == nil {
            /** Note: You must include the activityType string below in your Info.plist file under the `NSUserActivityTypes` array.
                More info: https://developer.apple.com/documentation/foundation/nsuseractivity
            */
            currentUserActivity = NSUserActivity(activityType: "com.FZ.StateRestoration.mainActivity")
        }
        
        // Add the presented state.
        currentUserActivity?.addUserInfoEntries(from: ["EditedText": textView.text ?? "Write text here"])
        
        view.window?.windowScene?.userActivity = currentUserActivity
    }
    
    func setupScene(with userActivity: NSUserActivity) {
        if let userInfo = userActivity.userInfo {
            // Decode the user activity product identifier from the userInfo.
            if let editedText = userInfo["EditedText"] as? String {
                textView.text = editedText
            }            
        }
        else {
            Swift.debugPrint("Failed to restore scene from \(userActivity)")
        }
    }

    override func applicationFinishedRestoringState() {
        let action = UIAlertController(title: "Data Restored", message: "Text field updated", preferredStyle: .alert)
        action.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(action, animated: true, completion: nil)
    }
}

