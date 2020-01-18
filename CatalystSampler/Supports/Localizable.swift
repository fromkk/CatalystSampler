//
//  Localizable.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/01/18.
//  Copyright © 2020 fromKK. All rights reserved.
//

import Foundation

protocol Localizable: RawRepresentable where RawValue == String {}
extension Localizable {
    func localized(tableName: String? = nil, bundle: Bundle = .main) -> String {
        return NSLocalizedString(rawValue, tableName: tableName, bundle: bundle, comment: rawValue)
    }
}
