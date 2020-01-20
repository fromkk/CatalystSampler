//
//  NSUserActivity+extenions.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/01/18.
//  Copyright © 2020 fromKK. All rights reserved.
//

import Foundation

extension NSUserActivity {
    static let contextMenu = NSUserActivity(
        activityType: "me.fromkk.CatalystSampler.ContextMenu"
    )
    static let toolbar = NSUserActivity(
        activityType: "me.fromkk.CatalystSampler.toolbar"
    )
    static let touchBar = NSUserActivity(
        activityType: "me.fromkk.CatalystSampler.touchBar"
    )
}
