//
//  ToolbarDelegate.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/01/19.
//  Copyright © 2020 fromKK. All rights reserved.
//

import UIKit
#if os(macOS)
import AppKit
#endif

#if targetEnvironment(macCatalyst)
extension NSToolbar.Identifier {
    static let customToolbar = NSToolbar.Identifier(
        "me.fromkk.CatalystSampler.customToolbar"
    )
}

extension NSToolbarItem.Identifier {
    static let arrowGroup = NSToolbarItem.Identifier(
        "me.fromkk.CatalystSampler.arrowGroup"
    )
    static let reload = NSToolbarItem.Identifier(
        "me.fromkk.CatalystSampler.reload"
    )
    static let favorite = NSToolbarItem.Identifier(
        "me.fromkk.CatalystSampler.favorite"
    )
}

final class ToolbarDelegate: NSObject, NSToolbarDelegate {
    private var isFavorite: Bool = false
    init(toolbar: NSToolbar) {
        super.init()
        toolbar.displayMode = .iconOnly
        toolbar.delegate = self
        toolbar.insertItem(withItemIdentifier: .arrowGroup, at: 0)
        toolbar.insertItem(withItemIdentifier: .reload, at: 1)
    }

    private lazy var arrowGroup = NSToolbarItemGroup(
        itemIdentifier: .arrowGroup,
        images: [
            UIImage(systemName: "chevron.left")!,
            UIImage(systemName: "chevron.right")!
        ], selectionMode: .momentary, labels: [
            "Prev",
            "Next"
        ], target: self,
           action: #selector(tapArrowGroup(_:))
    )
    
    private lazy var reload = NSToolbarItem(
        itemIdentifier: .reload,
        barButtonItem: UIBarButtonItem(
            image: UIImage(systemName: "arrow.clockwise.circle")!,
            style: .plain, target: self, action: #selector(tapReload(_:)))
    )
    
    private lazy var favorite = NSToolbarItem(
        itemIdentifier: .favorite,
        barButtonItem: UIBarButtonItem(
            image: UIImage(systemName: "star")!,
            style: .plain,
            target: self,
            action: #selector(tapFavorite(_:)))
    )

    @objc func tapArrowGroup(_ arrowGroup: NSToolbarItemGroup) {
        print(arrowGroup.selectedIndex)
    }
    
    @objc func tapReload(_ reload: NSToolbarItem) {
        print("reload")
    }
    
    @objc func tapFavorite(_ favorite: NSToolbarItem) {
        isFavorite.toggle()
        if isFavorite {
            favorite.image = UIImage(systemName: "star.fill")!
        } else {
            favorite.image = UIImage(systemName: "star")!
        }
    }

    func toolbarAllowedItemIdentifiers(
        _ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [.arrowGroup, .reload, .flexibleSpace, .favorite]
    }
    
    func toolbarDefaultItemIdentifiers(
        _ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [.arrowGroup, .reload, .flexibleSpace, .favorite]
    }
    
    func toolbar(
        _ toolbar: NSToolbar,
        itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
        willBeInsertedIntoToolbar flag: Bool
    ) -> NSToolbarItem? {
        switch itemIdentifier {
        case .arrowGroup:
            return arrowGroup
        case .reload:
            return reload
        case .favorite:
            return favorite
        default:
            return nil
        }
    }
}
#endif
