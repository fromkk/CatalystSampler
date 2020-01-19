//
//  ToolbarView.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/01/18.
//  Copyright © 2020 fromKK. All rights reserved.
//

import SwiftUI
import UIKit

extension NSUserActivity {
    static let toolbar = NSUserActivity(
        activityType: "me.fromkk.CatalystSampler.toolbar"
    )
}

struct ToolbarView: View {
    var body: some View {
        VStack {
            Text("toolbar")
        }
    }
}

struct ToolbarView_Preview: PreviewProvider {
    static var previews: some View {
        ToolbarView()
    }
}
