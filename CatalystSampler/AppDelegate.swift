//
//  AppDelegate.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/01/18.
//  Copyright © 2020 fromKK. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        #if targetEnvironment(macCatalyst)
        NSTouchBar.isAutomaticCustomizeTouchBarMenuItemEnabled = true
        #endif
        return true
    }

#if targetEnvironment(macCatalyst)
override func buildMenu(with builder: UIMenuBuilder) {
    super.buildMenu(with: builder)
    MenuBarProvider.run(with: builder)
}
#endif

@objc func hoge() {
    print("hoge")
}

override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    #if targetEnvironment(macCatalyst)
    if action == UIMenu.hoge.action {
        return false
    } else {
        return super.canPerformAction(action, withSender: sender)
    }
    #else
    return super.canPerformAction(action, withSender: sender)
    #endif
}

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
