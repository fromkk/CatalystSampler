//
//  ContextTableView.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/01/18.
//  Copyright © 2020 fromKK. All rights reserved.
//

import UIKit
import SwiftUI

final class ContextTableViewController: UITableViewController {
    static let copyKeyCommand: UIKeyCommand = UIKeyCommand(title: "Copy", image: nil, action: #selector(ContextTableViewController.performCopy), input: "C", modifierFlags: [.command])
    
    lazy var items: [Int] = (0..<100).map { $0 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = String(items[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (elements) -> UIMenu? in
            let action = UIAction(title: "Action") { (_) in
                print("Action")
            }
            return UIMenu(title: "Menu", image: nil, identifier: nil, options: .displayInline, children: [
                ContextTableViewController.copyKeyCommand,
                action
            ])
        }
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == Self.copyKeyCommand.action {
            return true
        } else {
            return super.canPerformAction(action, withSender: sender)
        }
    }
    
    @objc func performCopy() {
        print(#function)
    }
    
}

struct ContextTableView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<ContextTableView>) -> ContextTableViewController {
        return ContextTableViewController()
    }
    
    func updateUIViewController(_ uiViewController: ContextTableViewController, context: UIViewControllerRepresentableContext<ContextTableView>) {
        // nothing todo
    }
}

struct ContextTableView_Previews: PreviewProvider {
    static var previews: some View {
        ContextTableView()
    }
}
