//
//  ContextMenuViewController.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/01/18.
//  Copyright © 2020 fromKK. All rights reserved.
//

import UIKit
import SwiftUI

final class ContextMenuViewController: UIViewController, UIContextMenuInteractionDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(type: .custom)
        button.setTitleColor(UIView().tintColor, for: .normal)
        button.setTitle("Hello world", for: .normal)
        let contextMenuInteraction = UIContextMenuInteraction(delegate: self)
        button.addInteraction(contextMenuInteraction)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }

    func contextMenuInteraction(_: UIContextMenuInteraction, configurationForMenuAtLocation _: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { ([UIMenuElement]) -> UIMenu? in
            let copyAction = UIAction(title: "Copy", image: nil, identifier: nil) { _ in
                // perform copy action
            }
            let pasteAction = UIAction(title: "Paste", image: nil, identifier: nil) { _ in
                // perform paste action
            }
            return UIMenu(title: "Menu", image: nil, identifier: nil, children: [copyAction, pasteAction])
        }
    }
}

struct ContextVCView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<ContextVCView>) -> ContextMenuViewController {
        return ContextMenuViewController()
    }
    
    func updateUIViewController(_ uiViewController: ContextMenuViewController, context: UIViewControllerRepresentableContext<ContextVCView>) {
        // nothing todo
    }
}

struct ContextVCView_Previews: PreviewProvider {
    static var previews: some View {
        ContextVCView()
    }
}
