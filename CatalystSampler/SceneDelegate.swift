//
//  SceneDelegate.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/01/18.
//  Copyright © 2020 fromKK. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    #if targetEnvironment(macCatalyst)
    var toolbarDelegate: ToolbarDelegate?
    #endif

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            func setUp<Content>(view: Content) where Content: View {
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UIHostingController(rootView: view)
                self.window = window
                window.makeKeyAndVisible()
            }
            
            func setUp(_ viewController: UIViewController) {
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UINavigationController(rootViewController: viewController
                )
                self.window = window
                window.makeKeyAndVisible()
            }

            func setUpDefaultView() {
                setUp(view: ContentView())
            }

            if let activityType = connectionOptions.userActivities.first?.activityType {
                switch activityType {
                case NSUserActivity.contextMenu.activityType:
                    setUp(view: NavigationView { ContextMenuView() })
                case NSUserActivity.toolbar.activityType:
                    let toolbarView = ToolbarView()
                    #if targetEnvironment(macCatalyst)
                    let toolbar = NSToolbar(identifier: .customToolbar)
                    toolbarDelegate = ToolbarDelegate(toolbar: toolbar)
                    toolbar.delegate = toolbarDelegate
                    windowScene.titlebar?.toolbar = toolbar
                    #endif
                    setUp(view: NavigationView { toolbarView } )
                case NSUserActivity.touchBar.activityType:
                    setUp(TouchBarViewController())
                default:
                    setUpDefaultView()
                }
            } else {
                setUpDefaultView()
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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


}

