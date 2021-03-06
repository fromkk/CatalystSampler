//
//  TouchBarView.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/01/18.
//  Copyright © 2020 fromKK. All rights reserved.
//

import SwiftUI

#if targetEnvironment(macCatalyst)
extension NSTouchBar.CustomizationIdentifier {
    static let myTouchBar = NSTouchBar.CustomizationIdentifier(
        "me.fromkk.CatalystSampler.MyTouchBar"
    )
    static let newTouchBar = NSTouchBar.CustomizationIdentifier(
        "me.fromkk.CatalystSampler.newTouchBar"
    )
}

extension NSTouchBarItem.Identifier {
    static let arrowGroup = NSTouchBarItem.Identifier(
        "me.fromkk.CatalystSampler.arrowGroup"
    )
    static let prev = NSTouchBarItem.Identifier(
        "me.fromkk.CatalystSampler.prev"
    )
    static let next = NSTouchBarItem.Identifier(
        "me.fromkk.CatalystSampler.next"
    )
    static let reload = NSTouchBarItem.Identifier(
        "me.fromkk.CatalystSampler.reload"
    )
    static let colorPicker = NSTouchBarItem.Identifier(
        "me.fromkk.CatalystSampler.ColorPicker"
    )
    static let popover = NSTouchBarItem.Identifier(
        "me.fromkk.CatalystSampler.PopOver"
    )
    static let share = NSPopoverTouchBarItem.Identifier(
        "me.fromkk.CatalystSampler.Share"
    )
    static let slide = NSPopoverTouchBarItem.Identifier(
        "me.fromkk.CatalystSampler.Slide"
    )
}
#endif

final class TouchBarViewController: UIViewController {
    #if targetEnvironment(macCatalyst)
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.customizationIdentifier = .myTouchBar
        touchBar.defaultItemIdentifiers = [
            .arrowGroup, .prev, .next, .reload,
            .flexibleSpace, .colorPicker, .popover, .share, .slide,
            .otherItemsProxy
        ]
        touchBar.customizationAllowedItemIdentifiers = [
            .arrowGroup, .prev, .next, .reload, .colorPicker, .popover, .share, .slide
        ]
        touchBar.delegate = self
        return touchBar
    }
    #endif
}

#if targetEnvironment(macCatalyst)
extension TouchBarViewController: NSTouchBarDelegate {
    func touchBar(
        _ touchBar: NSTouchBar,
        makeItemForIdentifier identifier: NSTouchBarItem.Identifier
    ) -> NSTouchBarItem? {
        switch identifier {
        case .arrowGroup:
            let item = NSGroupTouchBarItem(identifier: .arrowGroup, items: [
                NSButtonTouchBarItem(
                    identifier: .prev,
                    image: UIImage(systemName: "chevron.left")!,
                    target: self,
                    action: #selector(prev(_:))).build {
                        $0.customizationLabel = "Prev"
                        return $0
                },
                NSButtonTouchBarItem(
                    identifier: .next,
                    image: UIImage(systemName: "chevron.right")!,
                    target: self,
                    action: #selector(next(_:))).build {
                        $0.customizationLabel = "Forward"
                        return $0
                },
            ])
            item.customizationLabel = "Group"
            item.visibilityPriority = .high
            return item
        case .reload:
            let item = NSButtonTouchBarItem(
                identifier: .reload,
                image: UIImage(systemName: "arrow.clockwise.circle")!,
                target: self,
                action: #selector(reload(_:)))
            item.customizationLabel = "Reload"
            item.visibilityPriority = .high
            return item
        case .colorPicker:
            let item = NSColorPickerTouchBarItem(identifier: .colorPicker)
            item.target = self
            item.action = #selector(pickedColor(_:))
            item.visibilityPriority = .normal
            item.customizationLabel = "Color"
            return item
        case .popover:
            let item = NSPopoverTouchBarItem(identifier: .popover)
            item.collapsedRepresentationImage = UIImage(systemName: "square.split.2x1.fill")!
            item.visibilityPriority = .normal
            let newTouchBar = NSTouchBar()
            newTouchBar.customizationIdentifier = .newTouchBar
            newTouchBar.defaultItemIdentifiers = [.arrowGroup]
            newTouchBar.delegate = self
            item.popoverTouchBar = newTouchBar
            item.customizationLabel = "Popover"
            return item
        case .share:
            let item = NSSharingServicePickerTouchBarItem(identifier: .share)
            item.activityItemsConfiguration = self
            item.visibilityPriority = .normal
            return item
        case .slide:
            let item = NSSliderTouchBarItem(identifier: .slide)
            item.label = "label"
            item.customizationLabel = "customizationLabel"
            item.minimumValueAccessory = NSSliderAccessory(
                image: UIImage(systemName: "minus.magnifyingglass")!
            )
            item.maximumValueAccessory = NSSliderAccessory(
                image: UIImage(systemName: "plus.magnifyingglass")!
            )
            item.action = #selector(slide(_:))
            item.target = self
            item.customizationLabel = "Slide"
            return item
        default:
            return nil
        }
    }
    
    @objc private func prev(_ touchBarItem: NSTouchBarItem) {
        print("prev")
    }
    
    @objc private func next(_ touchBarItem: NSTouchBarItem) {
        print("next")
    }
    
    @objc private func reload(_ touchBarItem: NSTouchBarItem) {
        print("reload")
    }

    @objc private func pickedColor(_ colorPickerItem: NSColorPickerTouchBarItem) {
        print("pickedColor \(colorPickerItem.color)")
    }
    
    @objc private func slide(_ sliderItem: NSSliderTouchBarItem) {
        print("slide \(sliderItem.value(forKey: "doubleValue"))")
    }
}

extension TouchBarViewController: UIActivityItemsConfigurationReading {
    var itemProvidersForActivityItemsConfiguration: [NSItemProvider] {
        return []
    }
}

#endif

struct TouchBarView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<TouchBarView>) -> TouchBarViewController {
        return TouchBarViewController()
    }
    
    func updateUIViewController(_ uiViewController: TouchBarViewController, context: UIViewControllerRepresentableContext<TouchBarView>) {
        // nothing todo
    }
}

struct TouchBarView_Preview: PreviewProvider {
    static var previews: some View {
        TouchBarView()
    }
}
