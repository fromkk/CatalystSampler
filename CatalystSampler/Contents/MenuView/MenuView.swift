//
//  MenuView.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/01/18.
//  Copyright © 2020 fromKK. All rights reserved.
//

import SwiftUI

enum MenuItem: String, Identifiable, CaseIterable, Localizable {
    var id: String { return rawValue }
    case contextMenu = "menu_context"
    case scene = "menu_scene"
    case toolbar = "menu_toolbar"
    case touchBar = "menu_touchbar"
}

struct MenuItemView: View {
    @State var isShowDontSupportMultipleWindow: Bool = false
    let menu: MenuItem
    var body: some View {
        Group {
            if menu == .contextMenu {
                NavigationLink(menu.localized(), destination: ContextMenuView())
            } else if menu == .scene {
                NavigationLink(menu.localized(), destination: SceneControlView())
            } else if menu == .toolbar {
                Button(action: {
                    self.showNewWindow(.toolbar)
                }, label: {
                    Text(menu.localized())
                })
            } else if menu == .touchBar {
                Button(action: {
                    self.showNewWindow(.touchBar)
                }, label: {
                    Text(menu.localized())
                })
            } else {
                EmptyView()
            }
        }.alert(isPresented: $isShowDontSupportMultipleWindow) {
            Alert(title: Text("Error"), message: Text("Don't support multiple window"), dismissButton: Alert.Button.default(Text("OK")))
        }
    }
    
    private func showNewWindow(_ userActivity: NSUserActivity) {
        if UIApplication.shared.supportsMultipleScenes {
            UIApplication.shared.requestSceneSessionActivation(nil, userActivity: userActivity, options: nil, errorHandler: nil)
            isShowDontSupportMultipleWindow = false
        } else {
            isShowDontSupportMultipleWindow = true
        }
    }
}

struct MenuListView: View {
    var body: some View {
        List(MenuItem.allCases) { menu in
            MenuItemView(menu: menu)
        }
    }
}

struct MenuListView_Preview: PreviewProvider {
    static var previews: some View {
        MenuListView()
    }
}
