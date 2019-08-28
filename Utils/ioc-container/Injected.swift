//
//  File.swift
//  
//
//  Created by Toby Youngberg on 8/20/19.
//

import Foundation

@propertyWrapper
public struct Injected<Value> {
    private var value: Value?
    public var projectedValue: Container = Container.shared
    public var wrappedValue: Value {
        mutating get {
            guard let value = value else {
                let newValue: Value = projectedValue.resolve()
                self.value = newValue
                return newValue
            }

            return value
        }
        mutating set {
            value = newValue
        }
    }

    public init() {}
}
