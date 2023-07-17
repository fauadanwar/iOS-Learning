//
//  SceneDelegate.swift
//  StateRestoration
//
//  Created by Fauad Anwar on 12/07/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        // Check whether the EditViewController is showing.
        if  let viewController = window?.rootViewController as? ViewController
        {
            viewController.updateUserActivity()
        }
        return scene.userActivity
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Determine the user activity from a new connection or from a session's state restoration.
        guard let activity = connectionOptions.userActivities.first ?? session.stateRestorationActivity else { return }
        
        if activity.activityType == "com.FZ.StateRestoration.mainActivity" {
            // The activity type is for restoring.
            
            // Present a parent detail view controller with the specified product and selected tab.
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            
            guard let viewController =
                    storyboard.instantiateViewController(withIdentifier: "ViewController")
                    as? ViewController else {
                Swift.debugPrint("Failed to create ViewController")
                return
            }
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()

            viewController.setupScene(with: activity)
            
            // Remember this activity for later when this app quits or suspends.
            scene.userActivity = userActivity
            
            /** Set the title for this scene to allow the system to differentiate multiple scenes for the user.
             If set to nil or an empty string, the system doesn't display a title.
             */
            scene.title = activity.title
            
        }
    }
}

