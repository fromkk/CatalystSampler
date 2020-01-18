//
//  ContextCollectionView.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/01/18.
//  Copyright © 2020 fromKK. All rights reserved.
//

import UIKit
import SwiftUI

final class ContextCollectionViewController: UICollectionViewController {
    lazy var items: [Int] = (0..<100).map { $0 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ContextCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ContextCollectionViewCell
        cell.textLabel.text = String(items[indexPath.item])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
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
}

extension ContextCollectionViewController {
    final class ContextCollectionViewCell: UICollectionViewCell {
        override init(frame: CGRect) {
            super.init(frame: frame)
            setUp()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setUp()
        }
        
        private lazy var setUp: () -> Void = {
            contentView.addSubview(textLabel)
            NSLayoutConstraint.activate([
                textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ])
            layer.borderColor = UIColor.label.cgColor
            layer.borderWidth = 1
            return {}
        }()

        let textLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 13)
            label.textColor = .label
            label.accessibilityIdentifier = "textLabel"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    }
}


#if DEBUG
@available(iOS 13.0, *)
struct ContextCollectionView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<ContextCollectionView>) -> ContextCollectionViewController {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 6
        layout.itemSize = CGSize(width: 120, height: 120)
        return ContextCollectionViewController(collectionViewLayout: layout)
    }
    
    func updateUIViewController(_ uiViewController: ContextCollectionViewController, context: UIViewControllerRepresentableContext<ContextCollectionView>) {
        // nothing todo
    }
}

@available(iOS 13.0, *)
struct ContextCollectionViewView_Preview: PreviewProvider {
    static var previews: some View {
        ContextCollectionView()
            .previewLayout(.sizeThatFits)
    }
}
#endif

