//
//  MenuBarProvider.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/01/19.
//  Copyright © 2020 fromKK. All rights reserved.
//

import UIKit

#if targetEnvironment(macCatalyst)
extension UIMenu.Identifier {
    static let custom: UIMenu.Identifier = .init("me.fromkk.CatalystSampler.custom")
}

extension UIMenu {
    static let hoge: UIAction = .init(title: "Hoge", handler: { _ in print("Hoge") })
    static let fuga: UIAction = .init(title: "Fuga", handler: { _ in print("Fuga") })
    static let custom: UIMenu = .init(title: "Custom", image: nil, identifier: .custom, options: [.destructive], children: [
        UIMenu.hoge,
        UIMenu.fuga
    ])
}

struct MenuBarProvider {
    static func run(with menuBuilder: UIMenuBuilder) {
        guard menuBuilder.system == .main else { return }
        menuBuilder.insertSibling(.custom, beforeMenu: .window)
    }
}

#endif
