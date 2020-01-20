//
//  WindowSceneEnvironmentObject.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/01/20.
//  Copyright © 2020 fromKK. All rights reserved.
//

import SwiftUI

final class WindowSceneEnvironmentObject: ObservableObject {
    let windowScene: UIWindowScene
    init(windowScene: UIWindowScene) {
        self.windowScene = windowScene
    }
}
