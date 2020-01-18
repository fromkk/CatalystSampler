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
    let menu: MenuItem
    var body: some View {
        Group {
            if menu == .contextMenu {
                NavigationLink(menu.localized(), destination: ContextMenuView())
            } else if menu == .scene {
                NavigationLink(menu.localized(), destination: SceneControlView())
            } else if menu == .toolbar {
                NavigationLink(menu.localized(), destination: ToolbarView())
            } else if menu == .touchBar {
                NavigationLink(menu.localized(), destination: TouchBarView())
            } else {
                EmptyView()
            }
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
