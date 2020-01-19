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
    
    @State var isShowDontSupportMultipleWindow: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.isShowDontSupportMultipleWindow = !self.openNewWindow()
            }, label: {
                Text("Open New Window")
            })
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
            
            Button(action: {
                self.isShowDontSupportMultipleWindow = !self.openNewWindowContextMenu()
            }, label: {
                Text("Open New Window Context Menu")
            })
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
            
            NavigationLink("Scene list", destination: SceneListView())
        }.alert(isPresented: $isShowDontSupportMultipleWindow) {
            Alert(title: Text("Error"), message: Text("Don't support multiple window"), dismissButton: Alert.Button.default(Text("OK")))
        }
    }
    
    private func openNewWindow() -> Bool {
        if UIApplication.shared.supportsMultipleScenes {
            UIApplication.shared.requestSceneSessionActivation(nil, userActivity: nil, options: nil, errorHandler: nil)
            return true
        } else {
            return false
        }
    }
    
    private func openNewWindowContextMenu() -> Bool {
        if UIApplication.shared.supportsMultipleScenes {
            UIApplication.shared.requestSceneSessionActivation(nil, userActivity: .contextMenu, options: nil, errorHandler: nil)
            return true
        } else {
            return false
        }
    }
}

struct SceneControlView_Preview: PreviewProvider {
    static var previews: some View {
        SceneControlView()
    }
}
