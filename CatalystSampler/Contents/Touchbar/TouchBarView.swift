//
//  TouchBarView.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/01/18.
//  Copyright © 2020 fromKK. All rights reserved.
//

import SwiftUI

struct TouchBarView: View {
    @EnvironmentObject var windowScene: WindowSceneEnvironmentObject
    var touchBarDelegate = TouchBarDelegate()
    var body: some View {
        VStack {
            Text("touch bar")
        }.onAppear {
            #if targetEnvironment(macCatalyst)
            self.windowScene.windowScene.touchBar = self.touchBarDelegate.makeTouchBar()
            #endif
        }
    }
}

struct TouchBarView_Preview: PreviewProvider {
    static var previews: some View {
        TouchBarView()
    }
}
