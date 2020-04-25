//
//  Builder.swift
//  CatalystSampler
//
//  Created by Kazuya Ueoka on 2020/04/25.
//  Copyright © 2020 fromKK. All rights reserved.
//

import Foundation

protocol Builder: AnyObject {
    init()
}

extension Builder {
    @discardableResult
    func build(_ builder: (Self) -> Self) -> Self {
        return builder(self)
    }

    @discardableResult
    static func build(_ builder: (Self) -> Self) -> Self {
        let object = Self()
        return builder(object)
    }
}

extension NSObject: Builder {}
