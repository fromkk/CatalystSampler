//
//  ContextMenuView.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/01/18.
//  Copyright © 2020 fromKK. All rights reserved.
//

import SwiftUI

struct ContextMenuView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("context menu") 
                .contextMenu(menuItems: {
                    NavigationLink("ViewController", destination: ContextVCView())
                    Button(action: {
                        // perform paste action
                    }) {
                        Text("Paste")
                    }
                }).padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
            NavigationLink("Table View", destination: ContextTableView())
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
            NavigationLink("Collection View", destination: ContextCollectionView())
            Spacer(minLength: 16)
        }
    }
}

struct ContextMenuView_Preview: PreviewProvider {
    static var previews: some View {
        ContextMenuView()
    }
}
