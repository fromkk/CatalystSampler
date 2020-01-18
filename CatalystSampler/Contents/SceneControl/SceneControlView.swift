//
//  SceneControlView.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/01/18.
//  Copyright © 2020 fromKK. All rights reserved.
//

import UIKit
import SwiftUI

struct SceneControlView: View {
    var body: some View {
        VStack {
            Button(action: {
                self.openNewWindow()
            }, label: {
                Text("Open New Window")
            })
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
            
            Button(action: {
                self.openNewWindowContextMenu()
            }, label: {
                Text("Open New Window Context Menu")
            })
        }
    }
    
    private func openNewWindow() {
        UIApplication.shared.requestSceneSessionActivation(nil, userActivity: nil, options: nil, errorHandler: nil)
    }
    
    private func openNewWindowContextMenu() {
        UIApplication.shared.requestSceneSessionActivation(nil, userActivity: .contextMenu, options: nil, errorHandler: nil)
    }
}

struct SceneControlView_Preview: PreviewProvider {
    static var previews: some View {
        SceneControlView()
    }
}
