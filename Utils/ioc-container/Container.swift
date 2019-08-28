//
//  Container.swift
//  
//
//  Created by Miles Wright on 8/20/19.
//

import Foundation
import Swinject

public enum ContainerError: LocalizedError {
    case failedToResolveType(Any.Type)
    case attemptedToRegisterNilObject(Any.Type)

    public var errorDescription: String? {
        switch self {
        case .failedToResolveType(let type):
            return "Failed to resolve \(type)"
        case .attemptedToRegisterNilObject(let type):
            return "Attempteed to register a nil object \(type)"
        }
    }
}

public struct Container {
    public static let shared = Container()

    private var _container = Swinject.Container()

    public func resolveSafely<T>(_ type: T.Type = T.self) throws -> T {
        guard let resolved = _container.resolve(type) else {
            throw ContainerError.failedToResolveType(type)
        }

        return resolved
    }

    public func resolve<T>(_ type: T.Type = T.self) -> T {
        do {
            return try resolveSafely(type)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    public func register<T>(_ instance: T, as interface: T.Type, configuration: @escaping (Container, T) -> Void = { _, _ in }) {
        _container.register(interface) { resolver -> T in
            return instance
        }
        .initCompleted { _, instance in
            configuration(self, instance)
        }
        .inObjectScope(.container)
    }

    public func register<T>(_ interface: T.Type, factory: @escaping (Container) -> T, configuration: @escaping (Container, T) -> Void = { _, _ in }) {
        _container.register(interface) { resolver -> T in
            return factory(self)
        }
        .initCompleted { _, instance in
            configuration(self, instance)
        }
        .inObjectScope(.transient)
    }

    public func register<T>(_ instance: T, configuration: @escaping (Container, T) -> Void = { _, _ in }) {
        register(instance, as: T.self, configuration: configuration)
    }

    public func register<T>(_ optionalInstance: Optional<T>, configuration: @escaping (Container, T) -> Void = { _, _ in }) {
        do {
            try registerSafely(optionalInstance, configuration: configuration)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    public func registerSafely<T>(_ optionalInstance: Optional<T>, configuration: @escaping (Container, T) -> Void = { _, _ in }) throws {
        guard let instance = optionalInstance else {
            throw ContainerError.attemptedToRegisterNilObject(T.self)
        }

        register(instance, as: T.self, configuration: configuration)
    }

    public func reset() {
        _container.removeAll()
    }
}
